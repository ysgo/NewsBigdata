package service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.opencsv.bean.CsvToBeanBuilder;

import vo.NewsVO;

@Service
public class NewsCrawlingService {
	@Autowired
	private Environment env;
	@Autowired
	private NewsAnalysisService analysisService;
	@Autowired
	private CheckInsertService checkInsertService;
	
//	@Scheduled(cron="0 0/50 9-18 * * *")	// 9시 ~ 18시까지 50분 간격으로 실행
	@Scheduled(fixedDelay=180000)	// 시작 후 30분 뒤부터 시작
	public void scheduleRun() {
		String accessKey = env.getProperty("etri.KEY"); // 발급받은 API Key
		String newsFilePath = env.getProperty("newsFile.url");
		checkInsertService.checkZone();
		crawlingNews(newsFilePath);
		List<NewsVO> list = loadNewsData(newsFilePath);
		// 수집 데이터 분석 저장 | 예외 처리 필요 
		analysisService.runNewsAnalysis(list, accessKey);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<NewsVO> loadNewsData(String newsFilePath) {
		List<NewsVO> list = null;
		try (FileInputStream fis = new FileInputStream(newsFilePath);
				InputStreamReader isr = new InputStreamReader(fis, "EUC-KR");) {
			list = new CsvToBeanBuilder(isr).withSkipLines(1).build().parse();
		} catch (FileNotFoundException e) {
			System.out.println("File not found!");
		} catch (IOException e) {
			System.out.println("Input and Output Error!");
		} catch (NullPointerException e) {
			System.out.println("Null value Error!");
		}
		return list;
	}
	
	public void crawlingNews(String newsFilePath) {
		RConnection rc = null;
		try {
			rc = new RConnection();
			rc.eval("driverClass <- '" + env.getProperty("rdb.class") + "'");
			rc.eval("connectPath <- '" + env.getProperty("mysql-connector.url") + "'");
			rc.eval("driver <- '" + env.getProperty("rdb.driver") + "'");
			rc.eval("userName <- '" + env.getProperty("db.userName") + "'");
			rc.eval("password <- '" + env.getProperty("db.password") + "'");
			rc.eval("seleniumIP <- '" + env.getProperty("selenium.ip") + "'");
			rc.eval("seleniumPort <- " + env.getProperty("selenium.port"));
			rc.eval("seleniumBrowser <- '" + env.getProperty("selenium.browser") + "'");
			rc.eval("path <- '" + newsFilePath + "'");
			rc.eval("source('" + env.getProperty("r.url") + "')");
		} catch (RserveException e) {
			System.out.println("Failed Rserve Server! Check the Rserve Server");
			System.out.println("But now I will ignore the error due to the problem of language support!");
		} finally {
			if (rc != null)
				rc.close();
		}
	}
}
