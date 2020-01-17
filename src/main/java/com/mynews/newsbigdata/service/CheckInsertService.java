package com.mynews.newsbigdata.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.NewsAnalysisMapper;
import com.mynews.newsbigdata.model.AnalysisVO;
import com.mynews.newsbigdata.model.NewsAnalysisVO;
import com.mynews.newsbigdata.model.ProvinceVO;
import com.mynews.newsbigdata.model.SigunguVO;
import com.opencsv.bean.CsvToBeanBuilder;

@Service
public class CheckInsertService {
	@Autowired
	private Environment env;
	@Autowired
	NewsAnalysisMapper mapper;

	public boolean insert(Object vo, String zoneName) {
		boolean result = false;
		if (zoneName.equals("province"))
			result = mapper.insertProvince(vo);
		else if (zoneName.equals("sigungu"))
			result = mapper.insertSigungu(vo);
		return result;
	}

	public boolean emptyZone(HashMap<String, String> map) {
		return mapper.emptyZone(map);
	}

	public boolean districtZone(NewsAnalysisVO vo) {
		return mapper.districtZone(vo);
	}

	public List<String> zoneTitle(NewsAnalysisVO vo) {
		return mapper.zoneTitle(vo);
	}

	public List<ProvinceVO> provinceList() {
		return mapper.listProvince();
	}

	public List<SigunguVO> sigunguList() {
		return mapper.listSigungu();
	}

	public int getProvince(AnalysisVO vo) {
		return mapper.getProvince(vo);
	}

	public NewsAnalysisVO getZone(NewsAnalysisVO vo) {
		return mapper.getZone(vo);
	}

	public int getSigungu(AnalysisVO vo) {
		return mapper.getSigungu(vo);
	}

	public NewsAnalysisVO getCode(NewsAnalysisVO vo) {
		return mapper.getCode(vo);
	}

	public void checkZone() {
		String[] zoneName = { "province", "sigungu" };
		HashMap<String, String> map = new HashMap<>();
		for (int i = 0; i < zoneName.length; i++) {
			String name = zoneName[i];
			map.put("zoneName", name);
			if (emptyZone(map)) {
				loadCSV(name);
			} else {
				System.out.println(name + " database is not Empty!");
			}
		}
	}
	
	public void getZoneName() {
		// KoNLP로 지역 정보 얻기 (kormaps2014) 
	}

	public void loadCSV(String zoneName) {
		String csvURL = env.getProperty(zoneName + ".url");
		List<Object> list = null;
		try {
			list = loadCSV(csvURL, zoneName);
			Iterator<Object> it = list.iterator();
			while (it.hasNext()) {
				Object vo = it.next();
				if (insert(vo, zoneName))
					System.out.println("Insert Success!");
				else
					System.out.println("Insert Failed!");
			}
		} catch (NullPointerException e) {
			System.out.println("List is not Empty!");
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Object> loadCSV(String csvURL, String zoneName) {
		List<Object> list = null;
		try (FileInputStream fis = new FileInputStream(csvURL);
				InputStreamReader isr = new InputStreamReader(fis, "EUC-KR");) {
			Class type = getClass();
			if (zoneName.equals("province"))
				type = ProvinceVO.class;
			else if (zoneName.equals("sigungu"))
				type = SigunguVO.class;
			list = new CsvToBeanBuilder(isr).withType(type).withSkipLines(1).build().parse();
		} catch (FileNotFoundException e) {
			System.out.println("File not found!");
		} catch (IOException e) {
			System.out.println("Input and Output Error!");
		} catch (NullPointerException e) {
			System.out.println("Null value Error!");
		}
		return list;
	}
}
