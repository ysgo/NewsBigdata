package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.Map;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RwordcloudsController {

	@RequestMapping("/wordclouds")
	@ResponseBody
	public Map<String, Object> Rwordclouds() {// �� ī�װ�
		RConnection r = null;
		Map<String, Object> keyMap  = new HashMap <String, Object>();
		try {
			r = new RConnection();
			REXP x = r.eval("imsi<-source('C:/Rstudy/bigkindsCrawling/wordclouds2.R');imsi$value");
			RList list = x.asList();

			String[] keywords = list.at("keyword").asStrings();
			String[] freqs = list.at("Freq").asStrings();
			String keyword;
			int freq;
			// r.eval("result<-dbGetQuery(conn,paste0('select content from bigkinds where
			// category='"+ctg+"'))'");
			for (int i = 0; i < keywords.length; i++) {
				keyword=keywords[i];
				freq=Integer.parseInt(freqs[i]);
				keyMap.put(keyword,freq);
				System.out.println(keyMap);
			}


	        
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			r.close();
		}
		return keyMap;
	}

	@RequestMapping(value = "/wordclouds", method = RequestMethod.GET)
	public ModelAndView wordclouds() {
		return new ModelAndView("wordclouds");
	}
}
