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
import vo.AnalysisVO;
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
    			int idx = service.getIdx(vo);
    			// title, contents 분석 후 insert
    			argument.put("text", vo.getTitle()+vo.getContent());
    			request.put("argument", argument);
    			
    			AnalysisVO al = service2.getAnalysisLocation(request, argument, openApiURL);
    			HashSet<Integer> provinces = al.getProvince();
    			HashSet<Integer> sigungus = al.getSigungu();
    			System.out.println("p"+provinces);
    			System.out.println("s"+sigungus);
    			NewsAnalysisVO analysisVO = null;
    			if(provinces.size() == 0 && sigungus.size() == 0) {
    				// 시도, 시군구 모두 없음
    				System.out.println("6");
    				analysisVO = new NewsAnalysisVO(idx);
    				System.out.println("6"+analysisVO.getP_code() + " " + analysisVO.getS_code());
    				System.out.println("idx: " + analysisVO.getIdx());
    				service2.contentZone(analysisVO);
    			} else {
    				if(provinces.size() != 0) {
    					System.out.println("시도 존재");
    					for(int province : provinces) {
    						System.out.println("시도 반복문");
    						if(sigungus.size() != 0) {
    							// 시도와 시군구 모두 존재
    							for(int sigungu : sigungus) {
    								System.out.println("시군구 반복문");
    								System.out.println("0");
    								analysisVO = service.getProvinceSample(new NewsAnalysisVO(idx, province, sigungu));
    								if(analysisVO != null) {
    									System.out.println("1");
    									System.out.println("1"+analysisVO.getP_code() + " " + analysisVO.getS_code());
    									analysisVO.setIdx(idx);
    									System.out.println("idx: " + analysisVO.getIdx());
    									service2.contentZone(analysisVO);
    								} else {
    									// 시도와 시군구가 일치하는 지명이 아님
    									
    									// 시도에 시군구 값을 0으로 설정
    									System.out.println("2");
    									analysisVO = new NewsAnalysisVO(idx, province);
    									System.out.println("2"+analysisVO.getP_code() + " " + analysisVO.getS_code());
    									System.out.println("idx: " + analysisVO.getIdx());
    									service2.contentZone(analysisVO);
    									
    									// 시군구에 해당하는 지역의 시도코드 검색하여 추가
    									System.out.println("3");
    									analysisVO.setS_code(sigungu);
    									analysisVO = service.getCode(analysisVO);
    									analysisVO.setIdx(idx);
    									System.out.println("3"+analysisVO.getP_code() + " " + analysisVO.getS_code());
    									System.out.println("idx: " + analysisVO.getIdx());
    									service2.contentZone(analysisVO);
    								}
    							}
    						} else {
    							// 시도에 해당하는 지역만
    							System.out.println("4");
    							analysisVO = new NewsAnalysisVO(idx, province);
    							System.out.println("4"+analysisVO.getP_code() + " " + analysisVO.getS_code());
    							System.out.println("idx: " + analysisVO.getIdx());
    							service2.contentZone(analysisVO);
    						}
    					}
    				} else {
    					// 시군구만 존재할 경우 관련 시도의 첫번째 행의 시도값 저장
    					if(sigungus.size() != 0) {
    						System.out.println("시군구만");
							for(int sigungu : sigungus) {
								System.out.println("5");
								analysisVO = service.getCode(new NewsAnalysisVO(idx, 0, sigungu));
								analysisVO.setIdx(idx);
								System.out.println("5"+analysisVO.getP_code() + " " + analysisVO.getS_code());
								System.out.println("idx: " + analysisVO.getIdx());
								service2.contentZone(analysisVO);
							}
						}
    				}
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