package com.mynews.newsbigdata.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mynews.newsbigdata.model.AnalysisVO;
import com.mynews.newsbigdata.model.NewsAnalysisVO;
import com.mynews.newsbigdata.model.ProvinceVO;
import com.mynews.newsbigdata.model.SigunguVO;

@Mapper
public interface NewsAnalysisMapper {
	public boolean emptyZone(HashMap<String, String> map);
	public boolean checkProvince(AnalysisVO vo);
	public boolean checkSigungu(AnalysisVO vo);
	public List<ProvinceVO> listProvince();
	public List<SigunguVO> listSigungu();
	public int getProvince(AnalysisVO vo);
	public int getSigungu(AnalysisVO vo);
	public NewsAnalysisVO getZone(NewsAnalysisVO vo);
	public NewsAnalysisVO getCode(NewsAnalysisVO vo);
	public List<String> zoneTitle(NewsAnalysisVO vo);
	public boolean districtZone(NewsAnalysisVO vo);
	public boolean insertProvince(Object vo);
	public boolean insertSigungu(Object vo);
}
