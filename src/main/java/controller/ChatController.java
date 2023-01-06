package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.ChatService;
import vo.Member;
import vo.Room;

@Controller
public class ChatController {
	
	private ChatService chatservice;
	
	@Autowired
	public void setChatservice(ChatService chatservice) {
		this.chatservice = chatservice;
	}

	@RequestMapping("/chatroom.htm")
	public String chatroomView(Model model) {
		
		List<Room> list = chatservice.getRoomList();
		model.addAttribute("list", list);
		
		return "chat/chatroom";
	}
	
	@RequestMapping("/memberlist.htm")
	public String memberlistView(Model model) {
		
		List<Member> list = chatservice.getMemberList();
		model.addAttribute("list", list);
		
		return "chat/memberlist";
	}
}
