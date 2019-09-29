package com.mynews.newsbigdata;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
@SessionAttributes("status")
public class MembershipController {
	@Inject
	private MemberService service;
	@Inject
	PasswordEncoder passwordEncoder;
	
	// 로그인 페이지 이동 
	@RequestMapping(value="/signIn.do", method=RequestMethod.GET)
	public ModelAndView signIn() {
		return new ModelAndView("signIn");
	}

	// 로그인 : 객체 정보를 추출해 세션에 저장, 암호화, 복호화 비교후 이동
	@RequestMapping(value="/signIn.do", method=RequestMethod.POST)
	public ModelAndView signIn(@ModelAttribute MemberVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView("signIn");

		if ( session.getAttribute("status") != null ){
            // 기존에 login이란 세션 값이 존재한다면
            session.removeAttribute("status"); // 기존값을 제거해 준다.
        }
		String pw = vo.getPassword();
		vo = service.viewMember(vo);
		if (vo != null) {
			boolean result = passwordEncoder.matches(pw, vo.getPassword());
			if (result) {
				mav.addObject("status", vo);
				mav.setViewName("home");
			} else {
				mav.addObject("status", null);
			}
		}
		return mav;
	}
	
	// 회원가입 페이지 이동
	@RequestMapping(value="/signUp.do", method=RequestMethod.GET)
	public ModelAndView signUp() {
		return new ModelAndView("signUp");
	}

	// 회원가입 : 서비스 객체에 저장
	@RequestMapping(value="/signUp.do", method=RequestMethod.POST)
	public ModelAndView signUp(@ModelAttribute MemberVO vo) throws Exception {
		ModelAndView mav = new ModelAndView("signUp");
		String enc_password = passwordEncoder.encode(vo.getPassword());
		vo.setPassword(enc_password);
		if (service.signup(vo)) {
			mav.addObject("status", vo);
			mav.setViewName("home");
		} else {
			mav.addObject("status", null);
		}
		return mav;
	}

	// 로그아웃
	@RequestMapping("/signOut.do")
	public String signOut(SessionStatus session) throws Exception {
		service.signout(session);
		return "redirect:/home.do";
	}
	
	// 마이페이지 이동
	@RequestMapping(value="/myPage.do", method=RequestMethod.GET)
	public ModelAndView myPage() {
		return new ModelAndView("myPage");
	}

	// 마이페이지 비밀번호 수정
	@RequestMapping(value="/updatePass.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updatePass(@ModelAttribute MemberVO vo,
			@SessionAttribute("status") MemberVO member,
			@RequestParam("update_password") String update_password)
			throws Exception {
		ModelAndView mav = new ModelAndView("myPage");
		boolean passCheck = passwordEncoder.matches(vo.getPassword(), member.getPassword());
		if (passCheck) {
			System.out.println(passCheck);
			System.out.println(update_password);
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
	@RequestMapping(value="/myPage.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView infoUpdate(@ModelAttribute MemberVO vo,
			@SessionAttribute("status") MemberVO member)
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
	@RequestMapping(value = "/withdrawal.do", method = RequestMethod.POST)
	public String withdrawal(@ModelAttribute MemberVO vo, @SessionAttribute("status") MemberVO user, 
			SessionStatus sessionClear, HttpServletResponse response)
			throws Exception {
		String path = "withdrawal";
		boolean passCheck = passwordEncoder.matches(vo.getPassword(), user.getPassword());
		if (passCheck) {
			String userId = user.getEmail();
			boolean result = service.withdrawal(userId);
			if (result) {
				sessionClear.setComplete();
				path = "redirect:/home.do";
			}
		}
		return path;
	}
}
