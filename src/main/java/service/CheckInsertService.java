package service;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.opencsv.bean.CsvToBeanBuilder;

import dao.NewsAnalysisDAO;
import vo.AnalysisVO;
import vo.NewsAnalysisVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@Service
public class CheckInsertService {
	@Autowired
	private Environment env;
	@Autowired
	NewsAnalysisDAO dao;

	public boolean insert(Object vo, String zoneName) {
		boolean result = false;
		if (zoneName.equals("province"))
			result = dao.insertProvince(vo);
		else if (zoneName.equals("sigungu"))
			result = dao.insertSigungu(vo);
		return result;
	}

	public boolean emptyZone(HashMap<String, String> map) {
		return dao.emptyZone(map);
	}

	public boolean districtZone(NewsAnalysisVO vo) {
		return dao.districtZone(vo);
	}
	
	public List<String> zoneTitle(NewsAnalysisVO vo) {
		return dao.zoneTitle(vo);
	}
	
	// 시도명 위도, 경도 전체 데이터 가져오기
	public List<ProvinceVO> provinceList() {
		return dao.provinceList();
	}
	
	// 시군구 위도, 경도 전체 데이터 가져오기
	public List<SigunguVO> sigunguList() {
		return dao.sigunguList();
	}
	
	public int getProvince(AnalysisVO vo) {
		return dao.getProvince(vo);
	}
	
	public NewsAnalysisVO getZone(NewsAnalysisVO vo) {
		return dao.getZone(vo);
	}
	
	public int getSigungu(AnalysisVO vo) {
		return dao.getSigungu(vo);
	}
	
	public NewsAnalysisVO getCode(NewsAnalysisVO vo) {
		return dao.getCode(vo);
	}
	
	public String loadCSV(@RequestParam("zoneName") String zoneName) {
		HashMap<String, String> map = new HashMap<>();
		map.put("zoneName", zoneName);
		String csvURL=env.getProperty(zoneName+".url");
		List<Object> list = null;
		if(emptyZone(map)) {
			try {
				list = loadCSV(csvURL, zoneName);
				Iterator<Object> it = list.iterator();
				while(it.hasNext()) {
					Object vo = it.next();
					if(insert(vo, zoneName))
						System.out.println("Insert Success!");
					else
						System.out.println("Insert Failed!");
				}
			} catch(NullPointerException e) {
				System.out.println("List is not Empty!");
			}
		} else
			System.out.println("Zone Database not Empty!");
		return "home";
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
