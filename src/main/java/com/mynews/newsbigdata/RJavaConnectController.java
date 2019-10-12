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
    			
    			// title, contents 분석 후 insert
    			argument.put("text", vo.getTitle()+vo.getContent());
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
    							// 시도와 시군구 모두 존재
    							for(String sigungu : sigungus) {
    								strMap.put("s_name", sigungu);
    								// 여기 잘못된 값 -> 경기도 양구는 일치하지 않음!
    								String checkProvince = service.getProvince(strMap);
    								if(checkProvince != null && checkProvince.contains(str[0]) && checkProvince.contains(str[1])) {
    									analysisVO = new NewsAnalysisVO(vo.getContent(), province, sigungu);
    									service2.contentZone(analysisVO);
    								} else {
    									// 시도에 시군구 NULL로 설정
    									analysisVO = new NewsAnalysisVO(vo.getContent(), province);
    									service2.contentZone(analysisVO);
    									
    									// 시군구에 해당하는 지역의 시도 검색하여 추가
    									StringBuilder getProvince = new StringBuilder(service.getProvinceSample(strMap));
    									if(getProvince.toString() != null) {
    										int len = getProvince.length();
    										if(len >= 5) {
    											getProvince.delete(2, len);
    										} else if (len >= 4) {
    											getProvince.deleteCharAt(1).deleteCharAt(2);
    										} else {
    											getProvince.deleteCharAt(len-1);
    										}
    										analysisVO = new NewsAnalysisVO(vo.getContent(), getProvince.toString(), sigungu);
    										service2.contentZone(analysisVO);
    									} else {
    										
    									}
    								}
    							}
    						} else {
    							// 시도에 해당하는 지역만
    							analysisVO = new NewsAnalysisVO(vo.getContent(), province);
    							service2.contentZone(analysisVO);
    						}
    					}
    				} else {
    					// 시군구만 존재할 경우 관련 시도의 첫번째 행의 시도값 저장
    					if(sigungus != null) {
							for(String sigungu : sigungus) {
								strMap.put("s_name", sigungu);
								String checkProvince = service.getProvince(strMap);
								analysisVO = new NewsAnalysisVO(vo.getContent(), checkProvince, sigungu);
								service2.contentZone(analysisVO);
							}
						}
    				}
    			} else {
    				// 시도, 시군구 모두 없음
    				analysisVO = new NewsAnalysisVO(vo.getContent());
    				service2.contentZone(analysisVO);
    			}
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