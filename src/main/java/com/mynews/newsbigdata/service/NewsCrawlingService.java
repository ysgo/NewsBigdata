package com.mynews.newsbigdata.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.model.NewsVO;
import com.opencsv.bean.CsvToBeanBuilder;

@Service
public class NewsCrawlingService {
	@Autowired
	private Environment env;
	@Autowired
	private NewsAnalysisService analysisService;
	@Autowired
	private CheckInsertService checkInsertService;
	
	public void scheduleRun() {
		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
		String newsFilePath = env.getProperty("newsFile.url");
		checkInsertService.checkZone();
		List<NewsVO> list = loadNewsData(newsFilePath);
		// 수집 데이터 분석 저장 | 예외 처리 필요 
		analysisService.runNewsAnalysis(list, accessKey);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<NewsVO> loadNewsData(String newsFilePath) {
		List<NewsVO> list = null;
		try (FileInputStream fis = new FileInputStream(newsFilePath);
				InputStreamReader isr = new InputStreamReader(fis, "EUC-KR");) {
			Class type = getClass();
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
