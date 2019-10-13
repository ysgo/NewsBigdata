package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.AnalysisVO;
import vo.NewsAnalysisVO;
import vo.NewsVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Repository
public class NewsDAO {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper.";
	
	// 뉴스 타이틀 전체출력
	public List<String> listAll() {
		String statement = mapperRoute+"allTitle";
		return session.selectList(statement);
	}
	
	// 지역명 뉴스 타이틀 불러오기
	public List<String> zoneTitle(HashMap<String, Object> map) {
		String statement = mapperRoute+"zoneTitle";
		return session.selectList(statement, map);
	}
	
	// 시도명 위도, 경도 전체 데이터 가져오기
	public List<ProvinceVO> provinceList() {
		String statement = mapperRoute+"listProvince";
		return session.selectList(statement);
	}
	
	// 시군구 위도, 경도 전체 데이터 가져오기
	public List<SigunguVO> sigunguList() {
		String statement = mapperRoute+"listSigungu";
		return session.selectList(statement);
	}
	// 뉴스 키워드 출력
		public List<NewsVO> selectKeyword() {
			String statement = mapperRoute+"searchKeyWord";
			return session.selectList(statement);
		}
	
	// 뉴스 타이틀 검색으로 기사 내용 가져오기
	public NewsVO readNews(NewsVO vo) {
		String statement = mapperRoute+"readNews";
		return session.selectOne(statement, vo);
	}
	
	public int insertNews(NewsVO vo) {
		String statement = mapperRoute+"insertNews";
		return session.insert(statement,vo);
	}
	
	public int getIdx(NewsVO vo) {
		String statement = mapperRoute+"getIdx";
		return session.selectOne(statement, vo);
	}
	
	// s_name에 해당하는 p_name 검색
	public int getProvince(AnalysisVO vo) {
		String statement = mapperRoute + "getProvince";
		return session.selectOne(statement, vo);
	}
	public NewsAnalysisVO getProvinceSample(NewsAnalysisVO vo) {
		String statement = mapperRoute + "getProvinceSample";
		return session.selectOne(statement, vo);
	}
	public int getSigungu(AnalysisVO vo) {
		String statement = mapperRoute + "getSigungu";
		return session.selectOne(statement, vo);
	}
	
	public NewsAnalysisVO getCode(NewsAnalysisVO vo) {
		String statement = mapperRoute + "getCode";
		return session.selectOne(statement, vo);
	}
	
}
