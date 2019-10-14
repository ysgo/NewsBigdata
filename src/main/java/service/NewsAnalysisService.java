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
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import dao.NewsAnalysisDAO;
import vo.AnalysisVO;

@Service
public class NewsAnalysisService {
	@Autowired
	NewsAnalysisDAO dao;

	public AnalysisVO checkInsert(AnalysisVO vo) {
		int tmp = 0;
		if (dao.checkProvince(vo)) {
			tmp = dao.getProvince(vo);
			vo.getProvince().add(tmp);
		} else if (dao.checkSigungu(vo)) {
			tmp = dao.getSigungu(vo);
			vo.getSigungu().add(tmp);
		}
		return vo;
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
