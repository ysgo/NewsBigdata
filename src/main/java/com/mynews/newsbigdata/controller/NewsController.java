package com.mynews.newsbigdata.controller;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mynews.newsbigdata.model.News;
import com.mynews.newsbigdata.service.NewsService;

@RestController
@SessionAttributes("status")
@RequestMapping("news")
public class NewsController {
	@Autowired
	NewsService newsService;

	@GetMapping("/mainNews")
	public HashMap<String, Object> mainNews() {
		HashMap<String, Object> map = new HashMap<>();
		try {
			// map.put("todayNews", newsService.listAll());
		} catch (NullPointerException e) {
			System.out.println("NewsList or ProvinceList or SigunguList is null!");
		}
		return map;
	}

	@RequestMapping(value = "/readNews", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public News readNews(@ModelAttribute News vo) {
		try {
			vo = newsService.readNews(vo);
		} catch (NullPointerException e) {
			System.out.println("There is no matching article with the title!");
		}
		return vo;
	}
}
