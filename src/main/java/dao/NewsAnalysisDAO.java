package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.AnalysisVO;
import vo.NewsAnalysisVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Repository
public class NewsAnalysisDAO {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsZoneMapper.";
	
	public boolean emptyZone(HashMap<String, String> map) {
		String statement = mapperRoute + "emptyZone";
		int result = session.selectOne(statement, map);
		return result == 0 ? true : false;
	}
	
	public boolean checkProvince(AnalysisVO vo) {
		String statement = mapperRoute + "checkProvince";
		int result = session.selectOne(statement, vo);
		return result >= 1 ? true : false;
	}
	
	public boolean checkSigungu(AnalysisVO vo) {
		String statement = mapperRoute + "checkSigungu";
		int result = session.selectOne(statement, vo);
		return result >= 1 ? true : false;
	}
	
	public List<ProvinceVO> provinceList() {
		String statement = mapperRoute+"listProvince";
		return session.selectList(statement);
	}
	
	public List<SigunguVO> sigunguList() {
		String statement = mapperRoute+"listSigungu";
		return session.selectList(statement);
	}
	
	public int getProvince(AnalysisVO vo) {
		String statement = mapperRoute + "getProvince";
		return session.selectOne(statement, vo);
	}

	public int getSigungu(AnalysisVO vo) {
		String statement = mapperRoute + "getSigungu";
		return session.selectOne(statement, vo);
	}
	
	public NewsAnalysisVO getZone(NewsAnalysisVO vo) {
		String statement = mapperRoute + "getZone";
		return session.selectOne(statement, vo);
	}

	public NewsAnalysisVO getCode(NewsAnalysisVO vo) {
		String statement = mapperRoute + "getCode";
		return session.selectOne(statement, vo);
	}
	
	// 지역명 뉴스 타이틀 불러오기
	public List<String> zoneTitle(NewsAnalysisVO vo) {
		String statement = mapperRoute + "zoneTitle";
		return session.selectList(statement, vo);
	}
	
	public boolean districtZone(NewsAnalysisVO vo) {
		String statement = mapperRoute + "districtZone";
		return session.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean insertProvince(Object vo) {
		String statement = mapperRoute + "insertProvince";
		return session.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean insertSigungu(Object vo) {
		String statement = mapperRoute + "insertSigungu";
		return session.insert(statement, vo) == 1 ? true : false;
	}
}
