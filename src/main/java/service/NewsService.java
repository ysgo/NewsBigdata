package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.NewsDAO;
import vo.NewsVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Service
public class NewsService {
	@Autowired
	private NewsDAO dao;
	
	// 뉴스 타이틀 전체 출력
	public List<String> listAll() {
		return dao.listAll();
	}
	
	public List<String> zoneTitle(HashMap<String, Object> map) {
		return dao.zoneTitle(map);
	}
	
	// 시도명 위도, 경도 전체 데이터 가져오기
	public List<ProvinceVO> provinceList() {
		return dao.provinceList();
	}
	
	// 시군구 위도, 경도 전체 데이터 가져오기
	public List<SigunguVO> sigunguList() {
		return dao.sigunguList();
	}
	
	// 뉴스 타이틀 검색으로 기사 내용 가져오기
	public NewsVO readNews(NewsVO vo) {
		return dao.readNews(vo);
	}
	
	public int insertNews(NewsVO vo) {
		return dao.insertNews(vo);
	}
	
	public String getProvince(HashMap<String, Object> map) {
		return dao.getProvince(map);
	}
	public String getProvinceSample(HashMap<String, Object> map) {
		return dao.getProvinceSample(map);
	}
}
