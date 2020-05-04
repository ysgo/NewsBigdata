package com.pronews.news.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pronews.news.model.News;

@Mapper
public interface NewsMapper {
	public List<News> getAllTitles();

	public News getNewsById(int id);
	
	public News getNewsByTitle(News news);

	 public void loadNews(HashMap<String, String> map);

	 public List<News> selectTitle(News vo);

	 public List<News> search(News vo);

	 public int allListCount(News vo);

	 public int searchListCount(News vo);
}
