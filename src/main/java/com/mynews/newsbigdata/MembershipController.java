package com.mynews.newsbigdata;

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
import org.springframework.web.bind.support.SessionStatus;

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
	public int signUp(@ModelAttribute MemberVO vo, HttpSession session) throws Exception {
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		int result = service.signUp(vo) ? 1 : 0;
		if(result == 1) {
			session.setAttribute("memberInfo", vo);
		}
		return result;
	}
	
	@RequestMapping(value="/signIn", method=RequestMethod.POST)
	public int signIn(@ModelAttribute MemberVO vo, HttpSession session) {
		if (session.getAttribute("memberInfo") != null) {
			session.removeAttribute("memberInfo");
		}
		String pw = vo.getPassword();
		int result = 0;
		try {
			vo = service.viewMember(vo);
			boolean checkPassword = passwordEncoder.matches(pw, vo.getPassword());
			if(checkPassword) {
				session.setAttribute("memberInfo", vo);
				result = 1;
			} else {
				session.setAttribute("msg", "일치하는 정보가 존재하지 않습니다. 다시 입력해주세요.");
			}
		} catch(NullPointerException e) {
			System.out.println("Exception : There is no information corresponding to the information entered");
			session.setAttribute("msg", "일치하는 정보가 존재하지 않습니다. 다시 입력해주세요.");
		}
		return result;
	}
	
	@RequestMapping("/signOut")
	public void signOut(SessionStatus session) throws Exception {
		session.setComplete();
	}
}
