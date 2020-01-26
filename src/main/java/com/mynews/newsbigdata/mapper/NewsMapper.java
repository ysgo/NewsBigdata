package com.mynews.newsbigdata.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mynews.newsbigdata.model.News;

@Mapper
public interface NewsMapper {
	public List<News> getAllTitles();
	// public List<News> getAllTitles();

	// public int getId(News vo);

	// public News readNews(News vo);

	// public int insertNews(News vo);

	// public void loadNews(HashMap<String, String> map);

	// public List<News> selectTitle(News vo);

	// public List<News> search(News vo);

	// public int allListCount(News vo);

	// public int searchListCount(News vo);
}
