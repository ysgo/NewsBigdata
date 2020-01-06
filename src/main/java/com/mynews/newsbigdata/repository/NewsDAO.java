package com.mynews.newsbigdata.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynews.newsbigdata.model.NewsVO;

@Repository
public class NewsDAO {
	@Autowired
	SqlSession session;
	String mapperRoute = "resource.NewsMapper.";
	
	public List<String> listAll() {
		String statement = mapperRoute+"allTitle";
		return session.selectList(statement);
	}
	
	public int getIdx(NewsVO vo) {
		String statement = mapperRoute+"getIdx";
		return session.selectOne(statement, vo);
	}

	public NewsVO readNews(NewsVO vo) {
		String statement = mapperRoute+"readNews";
		return session.selectOne(statement, vo);
	}
	
	public List<NewsVO> selectKeyword() {
		String statement = mapperRoute + "searchKeyWord";
		return session.selectList(statement);
	}
	
	public int insertNews(NewsVO vo) {
		String statement = mapperRoute+"insertNews";
		return session.insert(statement,vo);
	}
	
	public void loadNews(HashMap<String, String> map) {
		String statement = mapperRoute+"loadNews";
		session.insert(statement, map);
	}
}
