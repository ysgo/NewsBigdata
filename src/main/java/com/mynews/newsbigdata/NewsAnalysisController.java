package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import service.NewsAnalysisService;

@Controller
public class NewsAnalysisController {
	@Autowired
	private Environment env;
	@Autowired
	private NewsAnalysisService service;

	@RequestMapping(value="/load", method=RequestMethod.GET)
	public String loadCSV(@RequestParam("zoneName") String zoneName) {
		// zoneName = province, sigungu
		HashMap<String, String> map = new HashMap<>();
		map.put("zoneName", zoneName);
		String csvURL=env.getProperty(zoneName+".url");
		List<Object> list = null;
		if(service.emptyZone(map)) {
			try {
				list = service.loadCSV(csvURL, zoneName);
				Iterator<Object> it = list.iterator();
				while(it.hasNext()) {
					Object vo = it.next();
					if(service.insert(vo, zoneName))
						System.out.println("Insert Success!");
					else
						System.out.println("Insert Failed!");
				}
			} catch(NullPointerException e) {
				System.out.println("List is not Empty!");
			}
		} else
			System.out.println("Zone Database not Empty!");
		return "home";
	}
}
