package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.Map;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RwordcloudsController {
	@Autowired
	private Environment env;
	
	@RequestMapping(value = "/wordclouds", method = RequestMethod.GET)
	public Map<String, Object> Rwordclouds(String ctg) {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		RConnection rc = null;
		try {
			rc = new RConnection();
			if(ctg == null || ctg.equals(""))
				rc.eval("ctg <- '전체'");
			else 
				rc.eval("ctg <- '" + ctg + "'");
			rc.eval("driverClass <- '" + env.getProperty("rdb.class") + "'");
			rc.eval("connectPath <- '" + env.getProperty("mysql-connector.url") + "'");
			rc.eval("driver <- '" + env.getProperty("rdb.driver") + "'");
			rc.eval("userName <- '" + env.getProperty("db.userName") + "'");
			rc.eval("password <- '" + env.getProperty("db.password") + "'");
			rc.eval("source('" + env.getProperty("wordclouds.url") + "', encoding='UTF-8')");
			REXP x = rc.eval("keyword30");
			RList list = x.asList();
			String[] keywords = list.at("keyword").asStrings();
			String[] freqs = list.at("Freq").asStrings();
			StringBuilder sb;
			int freq;
			for (int i = 0; i < keywords.length; i++) {
				sb = new StringBuilder(keywords[i]);
				freq = Integer.parseInt(freqs[i]);
				keyMap.put(sb.toString(), freq);
			}
			System.out.println(keyMap);
		} catch(RserveException e) {
        	System.out.println("Rserve 실패");
        } catch(REXPMismatchException e) {
        	System.out.println("R 문법 오류");
        } catch(NullPointerException e) {
        	System.out.println("Today newsdata is empty! You need to collect todat\'s newsdata ");
        } finally {
			rc.close();
		}
		return keyMap;
	}
}
