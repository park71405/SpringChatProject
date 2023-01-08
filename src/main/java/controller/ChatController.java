package controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ChatService;
import vo.Member;
import vo.Message;
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
	
	//쪽지 보내기 페이지
	@RequestMapping("/memberlist.htm")
	public String memberlistView(Model model) {
		
		List<Member> list = chatservice.getMemberList();
		model.addAttribute("list", list);
		
		return "chat/memberlist";
	}
	
	//쪽지함 
	@RequestMapping("/notelist.htm")
	public String notelistView(Model model, Principal principal) {
		
		String to_userid = principal.getName();
		
		List<Message> list = chatservice.getNoteListByUserid(to_userid);
		
		model.addAttribute("list", list);
		
		return "chat/notelist";
	}
	
}
