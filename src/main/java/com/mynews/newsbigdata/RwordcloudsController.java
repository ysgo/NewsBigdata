package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.Map;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
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
		RConnection r = null;
		try {
			r = new RConnection();
			if(ctg == null || ctg.equals(""))
				r.eval("ctg <- '전체'");
			else 
				r.eval("ctg <- '" + ctg + "'");
			r.eval("connectPath <- '" + env.getProperty("mysql-connector.url") + "'");
			r.eval("driver <- '" + env.getProperty("rdb.driver") + "'");
			r.eval("userName <- '" + env.getProperty("db.userName") + "'");
			r.eval("password <- '" + env.getProperty("db.password") + "'");
			r.eval("source('" + env.getProperty("wordclouds.url") + "',encoding='UTF-8')");
			REXP x = r.eval("keyword30");
			RList list = x.asList();
 
			String[] keywords = list.at("keyword").asStrings();
			String[] freqs = list.at("Freq").asStrings();
			String keyword;
			int freq;

			for (int i = 0; i < keywords.length; i++) {
				keyword = keywords[i];
				freq = Integer.parseInt(freqs[i]);
				keyMap.put(keyword, freq);
			}
			System.out.println(keyMap);
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			r.close();
		}
		return keyMap;
	}
}
