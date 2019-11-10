package service;

import java.util.HashMap;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import dao.NewsDAO;

@Service
public class NewsCrawlingService {
	@Autowired
	private Environment env;
//	@Autowired
//	private ResourceLoader resourceLoader;
//	@Autowired
//	private NewsService newsService;
	@Autowired
	private NewsDAO newsDAO;
	@Autowired
	private NewsAnalysisService analysisService;
	@Autowired
	private CheckInsertService checkInsertService;
	
//	@Scheduled(cron="0 0/50 9-18 * * *")	// 9시 ~ 18시까지 50분 간격으로 실행
	@Scheduled(fixedDelay=180000)	// 시작 후 30분 뒤부터 시작
	public void scheduleRun() {
		// 지역정보 로드방식도 수정(하나로)
		checkInsertService.loadCSV("province");
		checkInsertService.loadCSV("sigungu");
		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
//		Map<String, Object> request = new HashMap<>();
//		Map<String, String> argument = new HashMap<>();
//		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
//		String analysisCode = "ner"; // 언어 분석 코드
//		argument.put("analysis_code", analysisCode);
//		request.put("access_key", accessKey);
		RConnection rc = null;
         try {
        	rc = new RConnection();
        	rc.eval("driverClass <- '" + env.getProperty("rdb.class") + "'");
			rc.eval("connectPath <- '" + env.getProperty("mysql-connector.url") + "'");
			rc.eval("driver <- '" + env.getProperty("rdb.driver") + "'");
			rc.eval("userName <- '" + env.getProperty("db.userName") + "'");
			rc.eval("password <- '" + env.getProperty("db.password") + "'");
        	rc.eval("seleniumIP <- '" + env.getProperty("selenium.ip") + "'");
        	rc.eval("seleniumPort <- " + env.getProperty("selenium.port"));
        	rc.eval("seleniumBrowser <- '" + env.getProperty("selenium.browser") + "'");
        	String newsPath = env.getProperty("news.url");
        	rc.eval("path <- '" + newsPath + "'");
        	rc.eval("source('" + env.getProperty("r.url") + "')");
        	insertNews(newsPath);
        	analysisService.runNewsAnalysis(accessKey);
//        	String path = env.getProperty("r.path");
//        	String p = resourceLoader.getResource(path).getURI().getPath();
//        	rc.eval("source('" + p + "')");
//        REXP x = rc.eval("result");
//    		RList list = x.asList();
//    		String[] newsname = list.at("newsname").asStrings();
//    		String[] title = list.at("title").asStrings();
//    		String[] category = list.at("category").asStrings();
//    		String[] date = list.at("date").asStrings();
//    		String[] url = list.at("url").asStrings();
//    		String[] content = list.at("content").asStrings();
//    		NewsVO vo = new NewsVO();
//    		for (int i=0;i<newsname.length;i++) {
//    			vo.setNewsname(newsname[i]);
//    			vo.setTitle(title[i]);
//    			vo.setCategory(category[i]);
//    			vo.setDate(date[i]);
//    			vo.setUrl(url[i]);
//    			vo.setContent(content[i]);
//    			if(newsService.insertNews(vo) !=1)
//    				System.out.println("입력 실패");
//    			int idx = newsService.getIdx(vo);
//    			
//    			argument.put("text", vo.getTitle()+vo.getContent());
//    			request.put("argument", argument);
//    			
//    			AnalysisVO al = analysisService.getAnalysisLocation(request, argument, openApiURL);
//    			HashSet<Integer> provinces = al.getProvince();
//    			HashSet<Integer> sigungus = al.getSigungu();
//    			NewsAnalysisVO analysisVO = null;
//    			if(provinces.size() == 0 && sigungus.size() == 0) {
//    				// 시도, 시군구 모두 없음
//    				analysisVO = new NewsAnalysisVO(idx);
//    				checkInsertService.districtZone(analysisVO);
//    			} else {
//    				if(provinces.size() != 0) {
//    					for(int province : provinces) {
//    						if(sigungus.size() != 0) {
//    							// 시도와 시군구 모두 존재
//    							for(int sigungu : sigungus) {
//    								analysisVO = checkInsertService.getZone(new NewsAnalysisVO(idx, province, sigungu));
//    								if(analysisVO != null) {
//    									analysisVO.setIdx(idx);
//    									checkInsertService.districtZone(analysisVO);
//    									
//    									analysisVO.setS_code(1);
//    									checkInsertService.districtZone(analysisVO);
//    								} else {
//    									// 시도와 시군구가 일치하는 지명이 아님
//    									// 시도에 시군구 값을 0으로 설정
//    									analysisVO = new NewsAnalysisVO(idx, province);
//    									checkInsertService.districtZone(analysisVO);
//    									
//    									// 시군구에 해당하는 지역의 시도코드 검색하여 추가
//    									analysisVO.setS_code(sigungu);
//    									analysisVO = checkInsertService.getCode(analysisVO);
//    									analysisVO.setIdx(idx);
//    									checkInsertService.districtZone(analysisVO);
//    								}
//    							}
//    						} else {
//    							// 시도에 해당하는 지역만
//    							analysisVO = new NewsAnalysisVO(idx, province);
//    							checkInsertService.districtZone(analysisVO);
//    						}
//    					}
//    				} else {
//    					// 시군구만 존재할 경우 관련 시도의 첫번째 행의 시도값 저장
//    					if(sigungus.size() != 0) {
//							for(int sigungu : sigungus) {
//								analysisVO = checkInsertService.getCode(new NewsAnalysisVO(idx, 1, sigungu));
//								analysisVO.setIdx(idx);
//								checkInsertService.districtZone(analysisVO);
//								analysisVO.setS_code(1);
//								checkInsertService.districtZone(analysisVO);
//							}
//						}
//    				}
//    			}
//    		}
        } catch(RserveException e) {
        	System.out.println("Failed Rserve");
        	e.printStackTrace();
        } 
//         catch(REXPMismatchException e) {
//        	System.out.println("R full of grammatical errors");
//        }
         catch(NullPointerException e) {
        	System.out.println("There's no analysis of the data we've collected!");
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	if(rc != null)
        		rc.close();
        }
    }
	
	public void insertNews(String newsPath) {
		/*
		 * 1. csv의 데이터 path 변수 저장 
		 * 2. dao와 mapper로 파라미터 전달 
		 * 3. mapper에서 load data file csv 실행 후 true, false  결과 받기 
		 * 4. 성공과 실패 여부로 종료 
		 */
		HashMap<String, String> map = new HashMap<>();
		map.put("newsPath", newsPath);
		newsDAO.loadNews(map);
	}
}
