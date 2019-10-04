package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

	@RequestMapping(value="/load.do", method=RequestMethod.GET)
	public void loadCSV(@RequestParam("zoneName") String zoneName) {
		HashMap<String, String> map = new HashMap<>();
		map.put("zoneName", zoneName);
		// zoneName = province, sigungu
		String csvURL=env.getProperty(map.get(zoneName)+".url");
		List<Object> list = null;
		if(service.emptyZone(map)) {
			list = service.loadCSV(csvURL);
			try {
				Iterator<Object> it = list.iterator();
				while(it.hasNext()) {
					Object tmp = it.next();
					if(service.insert(tmp, zoneName))
						System.out.println(tmp.toString());
					else
						System.out.println("Insert Failed!");
				}
			} catch(NullPointerException e) {
				System.out.println("List is not Empty!");
			}
		}
		else
			System.out.println("Zone Database not Empty!");
		System.out.println("Exit");
	}
}
