package com.mynews.newsbigdata;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import service.MemberService;
import vo.MemberVO;

@RestController
@SessionAttributes("memberInfo")
public class MembershipController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private MemberService service;
	@Inject
	PasswordEncoder passwordEncoder;

	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public HashMap<String, Object> signUp(@ModelAttribute MemberVO vo, HttpSession session) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		int result = service.signUp(vo) ? 1 : 0;
		if(result == 1)
			session.setAttribute("memberInfo", vo);
		map.put("result", result);
		map.put("memberInfo", vo);
		return map;
	}
	
	@RequestMapping(value="/signIn", method=RequestMethod.POST)
	public HashMap<String, Object> signIn(@ModelAttribute MemberVO vo, HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		if (session.getAttribute("memberInfo") != null) {
			session.removeAttribute("memberInfo");
		}
		String pw = vo.getPassword();
		int result = 0;
		try {
			vo = service.viewMember(vo);
			boolean checkPassword = passwordEncoder.matches(pw, vo.getPassword());
			if(checkPassword) {
				result = 1;
				session.setAttribute("memberInfo", vo);
			}
		} catch(NullPointerException e) {
			result = 0;
		} finally {
			map.put("result", result);
			map.put("memberInfo", vo);
		}
		return map;
	}
	
	@RequestMapping("/signOut")
	public int signOut(HttpSession session) throws Exception {
		int result = 0;
		if(session.getAttribute("memberInfo") != null) {
			service.signOut(session);
			result = 1;
		}
		return result;
	}
}
