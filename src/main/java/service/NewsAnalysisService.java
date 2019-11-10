package service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import dao.NewsAnalysisDAO;
import dao.NewsDAO;
import vo.AnalysisVO;
import vo.NewsAnalysisVO;
import vo.NewsVO;

@Service
public class NewsAnalysisService {
	@Autowired
	private NewsDAO newsDAO;
	@Autowired
	private NewsAnalysisDAO anlysisDao;
//	@Autowired
//	private NewsAnalysisService analysisService;
	@Autowired
	private CheckInsertService checkInsertService;

	public AnalysisVO checkInsert(AnalysisVO vo) {
		int tmp = 0;
		if (anlysisDao.checkProvince(vo)) {
			tmp = anlysisDao.getProvince(vo);
			vo.getProvince().add(tmp);
		} else if (anlysisDao.checkSigungu(vo)) {
			tmp = anlysisDao.getSigungu(vo);
			vo.getSigungu().add(tmp);
		}
		return vo;
	}
	
	public void runNewsAnalysis(String accessKey) {
		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
		String analysisCode = "ner";
		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();
		argument.put("analysis_code", analysisCode);
		request.put("access_key", accessKey);
		// mapper에 news_district idx 최대값보다 news_list의 값이 큰 데이터들 리스트로 조회 
		NewsVO vo = new NewsVO();
		// for문 길이 필요 
		for (int i=0;i<10;i++) {
			// 조회하는 데이터 어떤 건지에 대해 idx 
			int idx = newsDAO.getIdx(vo);
			argument.put("text", vo.getTitle()+vo.getContent());
			request.put("argument", argument);
			
			AnalysisVO al = getAnalysisLocation(request, argument, openApiURL);
			HashSet<Integer> provinces = al.getProvince();
			HashSet<Integer> sigungus = al.getSigungu();
			NewsAnalysisVO analysisVO = null;
			if(provinces.size() == 0 && sigungus.size() == 0) {
				// 시도, 시군구 모두 없음
				analysisVO = new NewsAnalysisVO(idx);
				checkInsertService.districtZone(analysisVO);
			} else {
				if(provinces.size() != 0) {
					for(int province : provinces) {
						if(sigungus.size() != 0) {
							// 시도와 시군구 모두 존재
							for(int sigungu : sigungus) {
								analysisVO = checkInsertService.getZone(new NewsAnalysisVO(idx, province, sigungu));
								if(analysisVO != null) {
									analysisVO.setIdx(idx);
									checkInsertService.districtZone(analysisVO);
									
									analysisVO.setS_code(1);
									checkInsertService.districtZone(analysisVO);
								} else {
									// 시도와 시군구가 일치하는 지명이 아님
									// 시도에 시군구 값을 0으로 설정
									analysisVO = new NewsAnalysisVO(idx, province);
									checkInsertService.districtZone(analysisVO);
									
									// 시군구에 해당하는 지역의 시도코드 검색하여 추가
									analysisVO.setS_code(sigungu);
									analysisVO = checkInsertService.getCode(analysisVO);
									analysisVO.setIdx(idx);
									checkInsertService.districtZone(analysisVO);
								}
							}
						} else {
							// 시도에 해당하는 지역만
							analysisVO = new NewsAnalysisVO(idx, province);
							checkInsertService.districtZone(analysisVO);
						}
					}
				} else {
					// 시군구만 존재할 경우 관련 시도의 첫번째 행의 시도값 저장
					if(sigungus.size() != 0) {
						for(int sigungu : sigungus) {
							analysisVO = checkInsertService.getCode(new NewsAnalysisVO(idx, 1, sigungu));
							analysisVO.setIdx(idx);
							checkInsertService.districtZone(analysisVO);
							analysisVO.setS_code(1);
							checkInsertService.districtZone(analysisVO);
						}
					}
				}
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	public AnalysisVO getAnalysisLocation(Map<String, Object> request, Map<String, String> argument,
			String openApiURL) {
		AnalysisVO al = new AnalysisVO();
		Gson gson = new Gson();
		URL url;
		Integer responseCode = null;
		String responBodyJson = null;
		Map<String, Object> responeBody = null;
		try {
			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(gson.toJson(request).getBytes("UTF-8"));
			wr.flush();
			wr.close();

			responseCode = con.getResponseCode();
			InputStream is = con.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			StringBuffer sb = new StringBuffer();

			String inputLine = "";
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			responBodyJson = sb.toString();
			if (responseCode != 200) {
				System.out.println("[error] " + responBodyJson);
			}

			responeBody = gson.fromJson(responBodyJson, Map.class);
			int result = ((Double) responeBody.get("result")).intValue();
			Map<String, Object> returnObject;
			List<Map<String, Object>> sentences;

			if (result != 0) {
				System.out.println("[error] " + responeBody.get("result"));
			} else {
				returnObject = (Map<String, Object>) responeBody.get("return_object");
				sentences = (List<Map<String, Object>>) returnObject.get("sentence");

				List<String> firstName = new ArrayList<>();
				for (Map<String, Object> sentence : sentences) {
					// 개체명 분석 결과 수집 및 정렬
					List<Map<String, Object>> NewsAnalysisVORecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
					for (Map<String, Object> NewsAnalysisVOInfo : NewsAnalysisVORecognitionResult) {
						StringBuilder name = new StringBuilder((String) NewsAnalysisVOInfo.get("text"));
						String type = String.valueOf(NewsAnalysisVOInfo.get("type"));
						int len = name.length();
						if (type.endsWith("PROVINCE") || type.endsWith("CAPITALCITY") || type.endsWith("ISLAND")
								|| type.endsWith("CITY") || type.endsWith("COUNTY")) {
							if (len >= 5) { 			// 제주특별자치도, 서울특별시
								name.delete(2, len);
							} else if (len >= 4) { 		// 전라북도, 충청남도, 경상남도, 서귀포시, 광주지역
								name.deleteCharAt(len - 1).deleteCharAt(1);
							} else if (len >= 3) {		// 전라도, 충북도, 경남도, 과천시, 강원도, 강화군, 장안구,
								name.deleteCharAt(len - 1);
							} else { 					// 전북, 충남, 경남, 중구, 양구, 서구, 동구 , 북(앞에 충남·)
								if (len != 1)
									firstName.add(name.substring(0, 1));
							}
							al.setStrSecond(name.toString());
							if (len == 1) {
								for (String data : firstName) {
									al.setStrFirst(data);
									al = checkInsert(al);
								}
							} else {
								al.setStrFirst(name.substring(0, 1));
								al.setStrSecond(name.substring(1, 2));
								al = checkInsert(al);
							}
						}
					}
				}
			}
		} catch (MalformedURLException e) {
			System.out.println("Analysis API Connect Exception Error!");
		} catch (IOException e) {
			System.out.println("Input&Output Exception Error!");
		}
		return al;
	}
}
