package com.mynews.newsbigdata.repository;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynews.newsbigdata.model.AnalysisVO;
import com.mynews.newsbigdata.model.NewsAnalysisVO;
import com.mynews.newsbigdata.model.ProvinceVO;
import com.mynews.newsbigdata.model.SigunguVO;

@Repository
public class NewsAnalysisDAO {
	private static final String NAMESPACE = "com.mynews.newsbigdata.NewsZoneMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public boolean emptyZone(HashMap<String, String> map) {
		String statement = NAMESPACE + "emptyZone";
		int result = sqlSession.selectOne(statement, map);
		return result == 0 ? true : false;
	}
	
	public boolean checkProvince(AnalysisVO vo) {
		String statement = NAMESPACE + "checkProvince";
		int result = sqlSession.selectOne(statement, vo);
		return result >= 1 ? true : false;
	}
	
	public boolean checkSigungu(AnalysisVO vo) {
		String statement = NAMESPACE + "checkSigungu";
		int result = sqlSession.selectOne(statement, vo);
		return result >= 1 ? true : false;
	}
	
	public List<ProvinceVO> provinceList() {
		String statement = NAMESPACE+"listProvince";
		return sqlSession.selectList(statement);
	}
	
	public List<SigunguVO> sigunguList() {
		String statement = NAMESPACE+"listSigungu";
		return sqlSession.selectList(statement);
	}
	
	public int getProvince(AnalysisVO vo) {
		String statement = NAMESPACE + "getProvince";
		return sqlSession.selectOne(statement, vo);
	}

	public int getSigungu(AnalysisVO vo) {
		String statement = NAMESPACE + "getSigungu";
		return sqlSession.selectOne(statement, vo);
	}
	
	public NewsAnalysisVO getZone(NewsAnalysisVO vo) {
		String statement = NAMESPACE + "getZone";
		return sqlSession.selectOne(statement, vo);
	}

	public NewsAnalysisVO getCode(NewsAnalysisVO vo) {
		String statement = NAMESPACE + "getCode";
		return sqlSession.selectOne(statement, vo);
	}
	
	// 지역명 뉴스 타이틀 불러오기
	public List<String> zoneTitle(NewsAnalysisVO vo) {
		String statement = NAMESPACE + "zoneTitle";
		return sqlSession.selectList(statement, vo);
	}
	
	public boolean districtZone(NewsAnalysisVO vo) {
		String statement = NAMESPACE + "districtZone";
		return sqlSession.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean insertProvince(Object vo) {
		String statement = NAMESPACE + "insertProvince";
		return sqlSession.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean insertSigungu(Object vo) {
		String statement = NAMESPACE + "insertSigungu";
		return sqlSession.insert(statement, vo) == 1 ? true : false;
	}
}
