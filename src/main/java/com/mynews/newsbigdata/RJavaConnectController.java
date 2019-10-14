package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import service.NewsAnalysisService;
import service.NewsService;
import vo.NewsAnalysisVO;
import vo.NewsVO;

@Controller
public class RJavaConnectController {
	@Autowired
	private Environment env;
	@Autowired
	private NewsService service;
	@Autowired
	private NewsAnalysisService service2;

	@RequestMapping("/rjavatest")
    public String rjavaConnect() {
         try {
        	String eval = "imsi<-source('"+env.getProperty("r.url").toString()+"');imsi$value";
            RConnection rc = new RConnection();
    		REXP x = rc.eval(eval);
    		RList list = x.asList();
    		
    		String[] newsname = list.at("newsname").asStrings();
    		String[] title = list.at("title").asStrings();
    		String[] category = list.at("category").asStrings();
    		String[] date = list.at("date").asStrings();
    		String[] url = list.at("url").asStrings();
    		String[] content = list.at("content").asStrings();
    		
    		NewsVO vo = new NewsVO();
    		
    		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
    		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
    		String analysisCode = "ner"; // 언어 분석 코드
    		
    		for (int i=0;i<newsname.length;i++) {
    			vo.setNewsname(newsname[i]);
    			vo.setTitle(title[i]);
    			vo.setCategory(category[i]);
    			vo.setDate(date[i]);
    			vo.setUrl(url[i]);
    			vo.setContent(content[i]);
    			if(service.insertNews(vo) !=1) {
    				System.out.println("입력 실패");
    			}
    			
    			Map<String, Object> request = new HashMap<>();
    			Map<String, String> argument = new HashMap<>();
    			argument.put("analysis_code", analysisCode);
    			argument.put("text", vo.getContent());
    			request.put("access_key", accessKey);
    			request.put("argument", argument);
    			
    			List<NewsAnalysisVO> list2 = service2.getAnalysisLocation(request, argument, openApiURL);
    			if (list2 != null) {
    				list2.stream().forEach(data -> {
    					StringBuilder sb = new StringBuilder();
    					HashMap<String, Object> map = new HashMap<>();
    					String type = data.getType();
    					if(type.endsWith("PROVINCE") || type.endsWith("CAPITALCITY")
    							|| type.endsWith("ISLAND") || type.endsWith("CITY")) {
    						// 시도 및 섬
    						System.out.println("시도");
    						System.out.println("[개체명] " + data.getText() + " (" + data.getCount() + ") " + data.getType());
    						int len = data.getText().length();
    						String text = data.getText();
    						if(len >= 4) {
    							sb.append(text.charAt(0)).append(text.charAt(2));
    						} else if(len == 3) {
    							sb.append(text.substring(0, 2));
    						} else {
    							sb.append(text);
    						}
    						System.out.println(sb.toString());
    						if(service.checkProvince(sb.toString()) != null) {
    							String[] tmp = sb.toString().split("");
    							HashMap<String, Object> splitStr = new HashMap<>();
    							splitStr.put("first", tmp[0]);
    							splitStr.put("second", tmp[1]);
    							
    							map.put("p_name", sb.toString());
    							map.put("s_name", service.searchSigungu(splitStr));
    						} else {
    							map.put("p_name", "서울특별시");
    							map.put("s_name", "종로구");
    						}
    					} else if(type.endsWith("COUNTY")) {
    						// 시군구
    						System.out.println("시군구");
    						System.out.println("[개체명] " + data.getText() + " (" + data.getCount() + ") " + data.getType());
    						String text = data.getText();
    						int len = data.getText().length();
    						if(len >= 3) {
    							sb.append(text.substring(len-3, len));
    						} else {
    							sb.append(text);
    						}
    						System.out.println(sb.toString());
    						
    						map.put("s_name", sb.toString());
    						// sigungu에 해당하는 province 코드 읽기
    						System.out.println(service.searchProvince(map));
    						map.put("p_name", service.searchProvince(map));
    					}
    					map.put("content", vo.getContent());
    					System.out.println(map);
//    					service2.contentZone(map);
    				});
    			} else {
    				System.out.println("해당 지명이 출력되지 않았기에 Default로 서울 뉴스 기사를 출력");
    				HashMap<String, Object> map = new HashMap<>();
    				map.put("content", vo.getContent());
    				map.put("province", "서울특별시");
    				map.put("sigungu", "종로구");
    				System.out.println(map);
    			}
    		}
        } catch(RserveException e) {
        	System.out.println("Rserve 실패");
        } catch(REXPMismatchException e) {
        	System.out.println("R 문법 오류");
        }
        return "home";
    }
}