package com.mynews.newsbigdata.repository;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynews.newsbigdata.model.NewsVO;

@Repository
public class NewsDetailDAO {
	private static final String NAMESPACE = "com.mynews.newsbigdata.NewsMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<NewsVO> allTitle() {
		String statement = NAMESPACE + "allTitle";
		return sqlSession.selectList(statement);
	}
	
	// 뉴스 타이틀 전체출력
	public List<NewsVO> selectTitle(NewsVO info) {
		String statement = NAMESPACE + "selectTitle";
		return sqlSession.selectList(statement,info);
	}

	// 뉴스 키워드로 검색된 것만 출력
	public List<NewsVO> search(NewsVO info) {
		String statement = NAMESPACE + "search";
		List<NewsVO> list = sqlSession.selectList(statement, info);
		return list;
	}
	
	public int allListCount(NewsVO info) {
		String statement = NAMESPACE + "allListCount";
		return sqlSession.selectOne(statement, info);
	}

	public int searchListCnt (NewsVO info) {
		String statement = NAMESPACE + "searchListCnt";
		return sqlSession.selectOne(statement, info);
	}
}
