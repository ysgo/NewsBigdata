package com.mynews.newsbigdata;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import service.MemberService;
import vo.MemberVO;

@Controller
@SessionAttributes("memberInfo")
public class MembershipController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private MemberService service;
	@Inject
	PasswordEncoder passwordEncoder;

	@ResponseBody
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public HashMap<String, Integer> signUp(@ModelAttribute MemberVO vo, HttpSession session) throws Exception {
		HashMap<String, Integer> map = new HashMap<>();
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		int result = service.signUp(vo) ? 1 : 0;
		if(result == 1)
			session.setAttribute("memberInfo", vo);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/signIn", method=RequestMethod.POST)
	public HashMap<String, Integer> signIn(@ModelAttribute MemberVO vo, HttpSession session) {
		HashMap<String, Integer> map = new HashMap<>();
		if (session.getAttribute("memberInfo") != null) {
			session.removeAttribute("memberInfo");
		}
		System.out.println(vo.toString());
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
		}
		return map;
	}

	// 로그아웃
	@RequestMapping("/signOut")
	public String signOut(SessionStatus session) throws Exception {
		service.signout(session);
		return "redirect:/home";
	}

	// 마이페이지 비밀번호 수정
	@RequestMapping(value = "/updatePass", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updatePass(@ModelAttribute MemberVO vo, @SessionAttribute("status") MemberVO member,
			@RequestParam("update_password") String update_password) throws Exception {
		ModelAndView mav = new ModelAndView("myPage");
		boolean passCheck = passwordEncoder.matches(vo.getPassword(), member.getPassword());
		if (passCheck) {
			String enc_password = passwordEncoder.encode(update_password);
			member.setPassword(enc_password);
			boolean result = service.updateMember(member);
			if (result) {
				mav.addObject("status", member);
			}
		}
		return mav;
	}

	// 마이페이지 닉네임 수정
	@RequestMapping(value = "/myPage", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView infoUpdate(@ModelAttribute MemberVO vo, @SessionAttribute("status") MemberVO member)
			throws Exception {
		ModelAndView mav = new ModelAndView("myPage");
		member.setUserName(vo.getUserName());
		boolean result = service.updateMember(member);
		if (result) {
			mav.addObject("status", member);
		}
		return mav;
	}

	// 회원탈퇴 기능 수행
	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST)
	public String withdrawal(@ModelAttribute MemberVO vo, @SessionAttribute("status") MemberVO user,
			SessionStatus sessionClear, HttpServletResponse response) throws Exception {
		String path = "withdrawal";
		boolean passCheck = passwordEncoder.matches(vo.getPassword(), user.getPassword());
		if (passCheck) {
			String userId = user.getEmail();
			boolean result = service.withdrawal(userId);
			if (result) {
				sessionClear.setComplete();
				path = "redirect:/home";
			}
		}
		return path;
	}
}
