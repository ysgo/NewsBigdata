package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsMapper;
import com.mynews.newsbigdata.model.NewsVO;

@Service
public class NewsService {
	@Autowired
	private NewsMapper mapper;
	
	public List<String> listAll() {
		return mapper.allTitle();
	}
	
	public NewsVO readNews(NewsVO vo) {
		return mapper.readNews(vo);
	}
	
	public int insertNews(NewsVO vo) {
		return mapper.insertNews(vo);
	}
	
	public int getIdx(NewsVO vo) {
		return mapper.getIdx(vo);
	}
	
}
