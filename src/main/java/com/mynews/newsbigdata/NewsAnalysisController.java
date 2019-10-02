package com.mynews.newsbigdata;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import service.NewsService;
import vo.NewsVO;

@Controller
public class NewsAnalysisController {
	@Autowired
	private Environment env;
	@Autowired
	NewsService service;
	
	@RequestMapping(value="/location.do")
	public void getAnalysisLocation(@ModelAttribute NewsVO vo) {
        String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
        String accessKey = env.getProperty("etri.KEY");   			// 발급받은 API Key
        String analysisCode = env.getProperty("etri.CODE");        	// 언어 분석 코드
        String text = service.readNews(vo).getContents();          	// 분석할 텍스트 데이터
        Gson gson = new Gson();
        
        Map<String, Object> request = new HashMap<>();
        Map<String, String> argument = new HashMap<>();
 
        argument.put("analysis_code", analysisCode);
        argument.put("text", text);
 
        request.put("access_key", accessKey);
        request.put("argument", argument);
 
        URL url;
        Integer responseCode = null;
        String responBody = null;
        try {
            url = new URL(openApiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);
 
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(gson.toJson(request).getBytes("UTF-8"));
            wr.flush();
            wr.close();
 
            responseCode = con.getResponseCode();
            InputStream is = con.getInputStream();
            byte[] buffer = new byte[is.available()];
            int byteRead = is.read(buffer);
            responBody = new String(buffer);
            
            System.out.println("[responseCode] " + responseCode);
            System.out.println("[responBody]" + responBody);
            System.out.println("[byteRead]" + byteRead);
 
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
