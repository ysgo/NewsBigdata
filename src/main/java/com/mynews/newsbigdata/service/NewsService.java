package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsMapper;
import com.mynews.newsbigdata.model.News;

@Service
public class NewsService {
	@Autowired
	private NewsMapper newsMapper;

	public List<News> getAllTitles() {
		return newsMapper.getAllTitles();
	}

	// public News readNews(News vo) {
	// return newsMapper.readNews(vo);
	// }

	// public int insertNews(News vo) {
	// return newsMapper.insertNews(vo);
	// }

	// public int getId(News vo) {
	// return newsMapper.getId(vo);
	// }

}
