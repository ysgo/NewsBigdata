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
import service.NewsService2;
import vo.NewsAnalysisVO;
import vo.TestVO;
@Controller
public class RJavaConnectController {
	@Autowired
	private Environment env;
	@Autowired
	private NewsService2 service;
	@Autowired
	private NewsAnalysisService service2;

	@RequestMapping("/rjavatest.do")
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
    		
    		TestVO vo=new TestVO();
    		
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
    			
    			Map<String, Object> request = new HashMap<>();
    			Map<String, String> argument = new HashMap<>();
    			argument.put("analysis_code", analysisCode);
    			argument.put("text", title[i]);
    			request.put("access_key", accessKey);
    			request.put("argument", argument);
    			
    			List<NewsAnalysisVO> list2 = service2.getAnalysisLocation(request, argument, openApiURL);
    			if (list2 != null) {
    				list2.stream().forEach(data -> {
    					if(data.getType().equals("LCP_PROVINCE") || data.getType().equals("LCP_CAPITALCITY")
    							|| data.getType().equals("LCG_ISLAND")) {
    						
    						// 시도 및 섬
    						
    						
    					} else if(data.getType().equals("LCP_COUNTRY") || data.getType().equals("LCP_CITY")) {
    						
    						// 시군구
    						
    						
    					}
    					System.out.println("[개체명] " + data.getText() + " (" + data.getCount() + ") " + data.getType());
    				});
    			} else
    				System.out.println("해당 지명이 출력되지 않았기에 Default로 서울 뉴스 기사를 출력");

    			
    			if(service.insertNews(vo) !=1) {
    				System.out.println("입력 실패");
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
