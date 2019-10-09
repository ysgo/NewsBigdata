package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.HashSet;
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
		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();
		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
		String analysisCode = "ner"; // 언어 분석 코드
		argument.put("analysis_code", analysisCode);
		request.put("access_key", accessKey);
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
    			
    			argument.put("text", vo.getContent());
    			request.put("argument", argument);
    			
    			Map<String, HashSet<String>> place = service2.getAnalysisLocation(request, argument, openApiURL);
    			HashSet<String> provinces = place.get("province");
    			HashSet<String> sigungus = place.get("sigungu");
    			NewsAnalysisVO analysisVO = null;
    			if (place.size() != 0) {
    				HashMap<String, Object> strMap = new HashMap<>();
    				if(provinces != null) {
    					for(String province : provinces) {
    						String[] str = province.split("");
    						strMap.put("strFirst", str[0]);
    						strMap.put("strSecond", str[1]);
    						if(sigungus != null) {
    							for(String sigungu : sigungus) {
    								strMap.put("s_name", sigungu);
    								String checkProvince = service.getProvince(strMap);
    								if(checkProvince != null && checkProvince.contains(str[0]) && checkProvince.contains(str[1])) {
    									analysisVO = new NewsAnalysisVO(vo.getContent(), province, sigungu);
    								} else {
    									continue;
    								}
    							}
    						} else {
    							analysisVO = new NewsAnalysisVO(vo.getContent(), province, service.getSigungu(strMap));
    						}
    					}
    				} else {
    					if(sigungus != null) {
							for(String sigungu : sigungus) {
								strMap.put("s_name", sigungu);
								String checkProvince = service.getProvince(strMap);
								analysisVO = new NewsAnalysisVO(vo.getContent(), checkProvince, sigungu);
							}
						}
    				}
    			} else {
    				System.out.println("해당 지명이 출력되지 않았기에 Default로 서울 뉴스 기사를 출력");
    				analysisVO = new NewsAnalysisVO(vo.getContent(), "서울", "종로");
    			}
    			service2.contentZone(analysisVO);
    		}
        } catch(RserveException e) {
        	System.out.println("Rserve 실패");
        } catch(REXPMismatchException e) {
        	System.out.println("R 문법 오류");
        } catch(NullPointerException e) {
        	System.out.println("Zone Value is Null");
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return "home";
    }
}