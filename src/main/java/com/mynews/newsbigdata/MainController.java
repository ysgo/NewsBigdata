package com.mynews.newsbigdata;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@RequestMapping("/mainPage.do")
	public String main() {
		return "main_news";
	}
}
