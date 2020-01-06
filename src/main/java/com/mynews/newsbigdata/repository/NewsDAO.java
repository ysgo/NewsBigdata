package com.mynews.newsbigdata.repository;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynews.newsbigdata.model.NewsVO;

@Repository
public class NewsDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String NAMESPACE = "com.mynews.newsbigdata.NewsMapper.";
	
	public List<String> listAll() {
		String statement = NAMESPACE + "allTitle";
		return sqlSession.selectList(statement);
	}
	
	public int getIdx(NewsVO vo) {
		String statement = NAMESPACE + "getIdx";
		return sqlSession.selectOne(statement, vo);
	}

	public NewsVO readNews(NewsVO vo) {
		String statement = NAMESPACE + "readNews";
		return sqlSession.selectOne(statement, vo);
	}
	
	public List<NewsVO> selectKeyword() {
		String statement = NAMESPACE + "searchKeyWord";
		return sqlSession.selectList(statement);
	}
	
	public int insertNews(NewsVO vo) {
		String statement = NAMESPACE + "insertNews";
		return sqlSession.insert(statement,vo);
	}
	
	public void loadNews(HashMap<String, String> map) {
		String statement = NAMESPACE + "loadNews";
		sqlSession.insert(statement, map);
	}
}
