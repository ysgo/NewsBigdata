package com.mynews.newsbigdata.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mynews.newsbigdata.model.News;
import com.mynews.newsbigdata.constants.PathConstants;

@Controller
@RequestMapping("/" + News.MULTIPLE)
public class MainController {
	@Value("${naver.ID}")
	private String naverId;

	@GetMapping
	public String viewMain(Model model) {
		model.addAttribute("naverID", naverId);
		return News.MULTIPLE + PathConstants.CRUD_INDEX;
	}
}
