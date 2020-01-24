package com.mynews.newsbigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsMapper;
import com.mynews.newsbigdata.model.News;

@Service
public class NewsDetailService {
	@Autowired
	private NewsMapper mapper;

	// 뉴스 타이틀 전체출력
	public List<News> selectTitle(News info) {
		System.out.println("서비스 - List에 들어옴");
		return mapper.selectTitle(info);
	}

	public List<News> search(News info) {
		System.out.println("서비스의 키워드값 : " + info.getKeyword());
		return mapper.search(info);
	}
	/*
	 * public List<Pagination> searchCnt(NewsVO info) {
	 * System.out.println("서비스 - SearachCnt에 들어옴"); return mapper.searchCnt(info); }
	 */
}
