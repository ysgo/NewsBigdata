package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsMapper;
import com.mynews.newsbigdata.model.News;

@Service
public class NewsService {
	@Autowired
	private NewsMapper mapper;
	
	public List<String> listAll() {
		return mapper.allTitle();
	}
	
	public News readNews(News vo) {
		return mapper.readNews(vo);
	}
	
	public int insertNews(News vo) {
		return mapper.insertNews(vo);
	}
	
	public int getIdx(News vo) {
		return mapper.getIdx(vo);
	}
	
}
