package service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.opencsv.bean.CsvToBeanBuilder;

import dao.NewsAnalysisDAO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Service
public class NewsAnalysisService {
	@Autowired
	NewsAnalysisDAO dao;
	
	@SuppressWarnings("unchecked")
	public Map<String, List<String>> getAnalysisLocation(Map<String, Object> request, 
			Map<String, String> argument, String openApiURL) {
		Map<String, List<String>> place = new HashMap<>();
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
			wr.flush(); wr.close();

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
				
				List<String> province = new ArrayList<>();
				List<String> sigungu = new ArrayList<>();
				for (Map<String, Object> sentence : sentences) {
					// 개체명 분석 결과 수집 및 정렬
					List<Map<String, Object>> NewsAnalysisVORecognitionResult = (List<Map<String, Object>>) sentence
							.get("NE");
					for (Map<String, Object> NewsAnalysisVOInfo : NewsAnalysisVORecognitionResult) {
						HashMap<String, Object> strMap = new HashMap<>();
						String name = (String) NewsAnalysisVOInfo.get("text");
						String type = String.valueOf(NewsAnalysisVOInfo.get("type"));
						int len = name.length();
						StringBuilder strTmp = new StringBuilder();
						if (type.endsWith("PROVINCE") || type.endsWith("CAPITALCITY") || type.endsWith("ISLAND")
								|| type.endsWith("CITY")) {
							// 시도명
							if (len >= 4) {
								strTmp.append(name.charAt(0)).append(name.charAt(2));
							} else if (len == 3) {
								strTmp.append(name.substring(0, 2));
							} else {
								strTmp.append(name);
							}
							String[] tmp = strTmp.toString().split("");
							strMap.put("strFirst", tmp[0]);
							strMap.put("strSecond", tmp[1]);
							if (checkProvince(strMap)) {
								province.add(strTmp.toString());
							}
						} else if (type.endsWith("COUNTY")) {
							// 시군구
							if (len >= 3) {
								strTmp.append(name.substring(len - 3, len));
							} else {
								strTmp.append(name);
							}
							strMap.put("str", strTmp.toString());
							if (checkSigungu(strMap)) {
								sigungu.add(strTmp.toString());
							}
						}
						place.put("province", province);
						place.put("sigungu", sigungu);
					}
				}
			}
		} catch (MalformedURLException e) {
//			e.printStackTrace();
			System.out.println("Analysis API Connect Exception Error!");
		} catch (IOException e) {
//			e.printStackTrace();
			System.out.println("Input&Output Exception Error!");
		}
		return place;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Object> loadCSV(String csvURL, String zoneName) {
		List<Object> list = null;
		try(FileInputStream fis = new FileInputStream(csvURL);
				InputStreamReader isr = new InputStreamReader(fis, "EUC-KR");) {
			Class type = getClass();
			if(zoneName.equals("province"))
				type=ProvinceVO.class;
			else if(zoneName.equals("sigungu"))
				type=SigunguVO.class;
			
			list = new CsvToBeanBuilder(isr)
					.withType(type)
					.withSkipLines(1)
					.build()
					.parse();
		} catch(FileNotFoundException e) {
			System.out.println("File not found!");
		} catch(IOException e) {
			System.out.println("Input and Output Error!");
		} catch(NullPointerException e) {
			System.out.println("Null value Error!");
		}
		return list;
	}
	
	public boolean insert(Object vo, String zoneName) {
		boolean result = false;
		if(zoneName.equals("province"))
			result = dao.insertProvince(vo);
		else if(zoneName.equals("sigungu"))
			result = dao.insertSigungu(vo);
		return result;
	}
	
	public boolean emptyZone(HashMap<String, String> map) {
		return dao.emptyZone(map);
	}
	
	public boolean contentZone(HashMap<String, Object> map) {
		return dao.contentZone(map);
	}
	
	public boolean checkProvince(HashMap<String, Object> map) {
		return dao.checkProvince(map);
	}
	
	public boolean checkSigungu(HashMap<String, Object> map) {
		return dao.checkSigungu(map);
	}
}
