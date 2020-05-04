package com.pronews.news.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pronews.news.constants.PathConstants;
import com.pronews.news.model.News;
import com.pronews.news.service.NewsService;
import com.pronews.news.service.NewsZonesService;

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

	@GetMapping(PathConstants.CRUD_DETAIL + "/{id}")
	public News readNews(@PathVariable("id") int id) {
		News news = null;
		try {
			news = newsService.getNewsById(id);
		} catch (NullPointerException e) {
			System.out.println("There is no matching article with the title!");
		}
		return news;
	}
}
