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

	@RequestMapping(value="/wordclouds.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> Rwordclouds() {
		Map<String, Object> keyMap  = new HashMap <String, Object>();
		RConnection r = null;
		try {
			r = new RConnection();
			String eval= "imsi<-source('C:/Rstudy/bigkindsCrawling/wordclouds2.R',encoding='UTF-8');imsi$value";
			REXP x = r.eval(eval);
			RList list = x.asList();
			String[] keywords = list.at("keyword").asStrings();
			String[] freqs = list.at("Freq").asStrings();
			String keyword;
			int freq;
		
			for (int i = 0; i < keywords.length; i++) {
				keyword=keywords[i];
				freq=Integer.parseInt(freqs[i]);
				keyMap.put(keyword,freq);
				
			}System.out.println(keyMap);
	        
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			r.close();
		}
		return keyMap;
	}
	
	/*
	 * @RequestMapping(value="/ctgkeyword.do", method = RequestMethod.GET)
	 * 
	 * @ResponseBody public String ctgName() { RConnection r = null; String ctg="";
	 * try { r = new RConnection(); String eval=
	 * "imsi<-source('C:/Rstudy/bigkindsCrawling/wordclouds2.R',encoding='UTF-8');";
	 * REXP x = r.eval(eval); RList list = x.asList(); String categ=
	 * "c('전체','정치','경제','사회','지역')";
	 * 
	 * r.eval("ctg<-'"+categ+"'");
	 * 
	 *  
	 * String[] keywords = list.at("keyword").asStrings(); String[] freqs =
	 * list.at("Freq").asStrings(); String keyword; int freq;
	 * 
	 * for (int i = 0; i < keywords.length; i++) { keyword=keywords[i];
	 * freq=Integer.parseInt(freqs[i]); keyMap.put(keyword,freq);
	 * 
	 * }System.out.println(keyMap);
	 * 
	 * } catch (Exception e) { System.out.println(e); e.printStackTrace(); } finally
	 * { r.close(); }
	 * 
	 * return ctg; }
	 */
	@RequestMapping(value = "/wordcloudsGET.do", method = RequestMethod.GET)
	public ModelAndView wordclouds() {
		return new ModelAndView("wordclouds");
	}
}
