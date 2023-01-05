package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	@RequestMapping("/index.htm")
	public String index() {
		return "index";
		//return "/WEB-INF/views/emp.jsp";
	}
	
	@RequestMapping("/kanban.htm")
	public String kanbanView() {
		
		return "kanban/kanban";
	}
	
	@RequestMapping("/Deeplearning.htm")
	public String DeepView() {
		return "deep/deep";
	}
	
	/*
	 * @RequestMapping("/chat.htm") public String chatView() { return "chat/chat"; }
	 */
	
}
