package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import utils.NaverLoginBO;

@Controller 
@RequestMapping("/naver")
public class NaverLoginController {
	
	@Autowired
	NaverLoginBO naverLoginBO;

	@RequestMapping(value="/login.htm", method=RequestMethod.GET)
	public String loginView(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) {
		
		String serverUrl = request.getScheme()+"://"+request.getServerName();
		if(request.getServerPort() != 80) {
			serverUrl = serverUrl + ":" + request.getServerPort();
		}
		
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session, serverUrl);
		model.addAttribute("naverAuthUrl", naverAuthUrl);
		
		return "naver/login";
	}
	
	@RequestMapping(value="/loginPostNaver.htm", method=RequestMethod.GET)
	public String loginPOSTNaver(HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
		
		String serverUrl = request.getScheme()+"://"+request.getServerName();
		if(request.getServerPort() != 80) {
			serverUrl = serverUrl + ":" + request.getServerPort();
		}

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state, serverUrl);
		if(oauthToken == null) {
			model.addAttribute("msg", "네이버 로그인 access 토큰 발급 오류 입니다.");
			model.addAttribute("url", "/");
			return "naver/loginPostNaver";
		}
		
		// 로그인 사용자 정보를 읽어온다
		String apiResult = naverLoginBO.getUserProfile(oauthToken, serverUrl);
		
		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		// 프로필 조회
		String id = (String) response_obj.get("id");
		String gender = (String) response_obj.get("gender");
		
		// 세션에 사용자 정보 등록
		session.setAttribute("islogin_r", "Y");
		session.setAttribute("id", id);
		session.setAttribute("gender", gender);
		
		return "naver/loginPostNaver";
	}
	
}
