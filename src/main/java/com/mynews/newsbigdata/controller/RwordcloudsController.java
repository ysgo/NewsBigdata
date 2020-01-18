package com.mynews.newsbigdata.controller;

import java.util.HashMap;
import java.util.Map;

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
		env.getProperty("");
		return keyMap;
	}
}
