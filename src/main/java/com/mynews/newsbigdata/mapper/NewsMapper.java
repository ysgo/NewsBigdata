package com.mynews.newsbigdata.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mynews.newsbigdata.model.NewsVO;

@Mapper
public interface NewsMapper {
	public List<String> allTitle();
	public int getIdx(NewsVO vo);
	public NewsVO readNews(NewsVO vo);
	public int insertNews(NewsVO vo);
	public void loadNews(HashMap<String, String> map);
	public List<NewsVO> selectTitle(NewsVO vo);
	public List<NewsVO> search(NewsVO vo);
	public int allListCount(NewsVO vo);
	public int searchListCount(NewsVO vo);
}
