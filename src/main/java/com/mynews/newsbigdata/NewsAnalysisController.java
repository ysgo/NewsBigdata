package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import service.NewsAnalysisService;
import vo.NewsAnalysisVO;
import vo.NewsVO;

@Controller
public class NewsAnalysisController {
	@Autowired
	private Environment env;
	@Autowired
	private NewsAnalysisService service;

	@RequestMapping(value = "/location.do", method = RequestMethod.GET)
	public void getAnalysisLocation(@ModelAttribute NewsVO vo) {
		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";
		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
		String analysisCode = "ner"; // 언어 분석 코드
		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();

		argument.put("analysis_code", analysisCode);
		argument.put("text", vo.getContents());

		request.put("access_key", accessKey);
		request.put("argument", argument);

		List<NewsAnalysisVO> list = service.getAnalysisLocation(request, argument, openApiURL);
		if (list != null) {

			list.stream().forEach(data -> {
				System.out.println("[개체명] " + data.getText() + " (" + data.getCount() + ") " + data.getType());
			});
		} else
			System.out.println("해당 지명이 출력되지 않았기에 Default로 서울 뉴스 기사를 출력");

		// 본문에 지명과 관련된 기사만 출력

	}
	
	@RequestMapping("/load.do")
	public void loadCSV() {
//	     CSVReader reader = new CSVReader(new FileReader("yourfile.csv"));
//	     String [] nextLine;
//	     while ((nextLine = reader.readNext()) != null) {
//	        // nextLine[] is an array of values from the line
//	        System.out.println(nextLine[0] + nextLine[1] + "etc...");
//	     }
//	     
//	     CSVReader reader = new CSVReader(new FileReader("yourfile.csv"));
//	     List<String[]> myEntries = reader.readAll();
//	     
//	     CSVIterator iterator = new CSVIterator(new CSVReader(new FileReader("yourfile.csv")));
//	     for(String[] nextLine : iterator) {
//	        // nextLine[] is an array of values from the line
//	        System.out.println(nextLine[0] + nextLine[1] + "etc...");
//	     }
//	     
//	     CSVReader reader = new CSVReader(new FileReader("yourfile.csv"));
//	     for(String[] nextLine : reader.iterator()) {
//	        // nextLine[] is an array of values from the line
//	        System.out.println(nextLine[0] + nextLine[1] + "etc...");
//	     }
//		or Annotation Method
	}
}
