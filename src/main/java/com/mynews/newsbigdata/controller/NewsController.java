package com.mynews.newsbigdata.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mynews.newsbigdata.model.News;
import com.mynews.newsbigdata.service.NewsService;
import com.mynews.newsbigdata.service.NewsZonesService;
import com.mynews.newsbigdata.constants.PathConstants;

@RestController
@RequestMapping("/" + News.MULTIPLE)
public class NewsController {
	@Autowired
	private NewsService newsService;
	@Autowired
	private NewsZonesService newsZonesService;

	@GetMapping(PathConstants.CRUD_MAIN)
	public HashMap<String, Object> mainNews() {
		HashMap<String, Object> map = new HashMap<>();
		try {
			map.put("todayNews", newsService.getAllTitles());
			map.put("province", newsZonesService.getAllProvinces());
			map.put("sigungu", newsZonesService.getAllSigungus());
		} catch (NullPointerException e) {
			System.out.println("NewsList or ProvinceList or SigunguList is null!");
		}
		return map;
	}

	@GetMapping(value = PathConstants.CRUD_DETAIL, produces = "application/json; charset=utf-8")
	public News readNews(@ModelAttribute News news) {
		try {
			news = newsService.getNewsByTitle(news);
		} catch (NullPointerException e) {
			System.out.println("There is no matching article with the title!");
		}
		return news;
	}
}
