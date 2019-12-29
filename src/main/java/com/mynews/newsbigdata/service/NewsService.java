package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.dao.NewsDAO;
import com.mynews.newsbigdata.vo.NewsVO;

@Service
public class NewsService {
	@Autowired
	private NewsDAO dao;
	
	public List<String> listAll() {
		return dao.listAll();
	}
	
	public NewsVO readNews(NewsVO vo) {
		return dao.readNews(vo);
	}
	
	public int insertNews(NewsVO vo) {
		return dao.insertNews(vo);
	}
	
	public int getIdx(NewsVO vo) {
		return dao.getIdx(vo);
	}
	
}
