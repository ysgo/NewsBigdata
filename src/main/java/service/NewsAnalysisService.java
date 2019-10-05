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
import vo.NewsAnalysisVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Service
public class NewsAnalysisService {
	@Autowired
	NewsAnalysisDAO dao;
	
	@SuppressWarnings("unchecked")
	public List<NewsAnalysisVO> getAnalysisLocation(Map<String, Object> request, Map<String, String> argument,
			String openApiURL) {
		Gson gson = new Gson();
		 
        URL url;
        Integer responseCode = null;
        String responBodyJson = null;
        Map<String, Object> responeBody = null;
        List<NewsAnalysisVO> nameEntities = null;
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
 
            if ( responseCode != 200 ) {
                System.out.println("[error] " + responBodyJson);
            }
            
            responeBody = gson.fromJson(responBodyJson, Map.class);
            int result = ((Double) responeBody.get("result")).intValue();
            Map<String, Object> returnObject;
            List<Map<String, Object>> sentences;
 
            if ( result != 0 ) {
                System.out.println("[error] " + responeBody.get("result"));
            } else {
            	returnObject = (Map<String, Object>) responeBody.get("return_object");
            	sentences = (List<Map<String, Object>>) returnObject.get("sentence");
            	
            	Map<String, NewsAnalysisVO> nameEntitiesMap = new HashMap<String, NewsAnalysisVO>();
            	
            	for( Map<String, Object> sentence : sentences ) {
            		// 개체명 분석 결과 수집 및 정렬
            		List<Map<String, Object>> NewsAnalysisVORecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
            		for( Map<String, Object> NewsAnalysisVOInfo : NewsAnalysisVORecognitionResult ) {
            			String name = (String) NewsAnalysisVOInfo.get("text");
            			NewsAnalysisVO NewsAnalysisVO = nameEntitiesMap.get(name);
            			String type = String.valueOf(NewsAnalysisVOInfo.get("type"));
            			if ( NewsAnalysisVO == null ) {
            				if(type.contains("LCP")) {
            					NewsAnalysisVO = new NewsAnalysisVO(name, type, 1);
            					nameEntitiesMap.put(name, NewsAnalysisVO);
            				}
            			} else {
            				if(type.contains("LCP")) {
            					NewsAnalysisVO.setCount(NewsAnalysisVO.getCount() + 1);
            				}
            			}
            		}
            	}
            	
            	if ( 0 < nameEntitiesMap.size() ) {
            		nameEntities = new ArrayList<NewsAnalysisVO>(nameEntitiesMap.values());
            		nameEntities.sort( (vo1, vo2) -> {
            			return vo2.getCount() - vo1.getCount();
            		});
            	}
            }
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
        return nameEntities;
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
	
	public boolean emptyZone(HashMap<String, String> map) {
		return dao.emptyZone(map);
	}
	
	public boolean insert(Object vo, String zoneName) {
		boolean result = false;
		if(zoneName.equals("province"))
			result = dao.insertProvince(vo);
		else if(zoneName.equals("sigungu"))
			result = dao.insertSigungu(vo);
		return result;
	}
}
