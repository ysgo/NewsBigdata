package com.pronews.news.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pronews.news.mapper.NewsMapper;
import com.pronews.news.model.News;

@Service
public class NewsService {
	@Autowired
	private NewsMapper newsMapper;

	public List<News> getAllTitles() {
		return newsMapper.getAllTitles();
	}

	public News getNewsByTitle(News news) {
		return newsMapper.getNewsByTitle(news);
	}
}
