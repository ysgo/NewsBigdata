package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsMapper;
import com.mynews.newsbigdata.model.News;

@Service
public class NewsDetailService {
	@Autowired
	private NewsMapper newsMapper;

	// 뉴스 타이틀 전체출력
	public List<News> selectTitle(News info) {
		return newsMapper.selectTitle(info);
	}

	public List<News> search(News info) {
		return newsMapper.search(info);
	}
}
