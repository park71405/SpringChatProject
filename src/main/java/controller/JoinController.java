package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import service.JoinService;
import vo.Member;

@Controller
@RequestMapping("/joinus/")
public class JoinController {
	
	//암호화
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JoinService service;
	
	//GET 요청 
	//회원가입 화면 처리
	@GetMapping("join.htm")
	public String join() {
		return "joinus/join";
	}
	
	//POST 요청
	//회원가입 기능 처리
	@PostMapping("join.htm")
	public String join(Member member) {
		int result = 0;
		String viewpage = "";
		//회원가입
		member.setPwd(this.bCryptPasswordEncoder.encode(member.getPwd()));
		//
		result = service.insertMember(member);
		if (result > 0) {
			System.out.println("삽입 성공");
			viewpage = "redirect:/index.htm";
		} else {
			System.out.println("삽입 실패");
			viewpage = "join.htm";
		}
		return viewpage;
    }
	
	//로그인 화면 처리
	@GetMapping(value="login.htm")
	public String login() {
		return "joinus/login";
	}
	
}