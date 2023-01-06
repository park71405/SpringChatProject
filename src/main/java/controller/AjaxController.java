package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import service.ChatService;
import vo.Message;
import vo.Room;
import vo.Roominuser;

@RestController 
@RequiredArgsConstructor
public class AjaxController {
	
	private ChatService chatservice;
	
	//특정 Broker로 메세지를 전달
	private final SimpMessagingTemplate template;
	
	@Autowired
	public void setChatservice(ChatService chatservice) {
		this.chatservice = chatservice;
	}
	
	//채팅방 전체 조회
	@RequestMapping(value="ajaxRoom.htm", method=RequestMethod.GET)
	public List<Room> RoomList(){
		List<Room> list = chatservice.getRoomList();
		return list;
	}
	
	//채팅방 개설
	@RequestMapping(value="ajaxRoom.htm", method=RequestMethod.POST)
	public String insertRoom(@RequestBody Room room) {
		
		String str = "";
		
		int result = chatservice.insertRoom(room);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//채팅방 삭제
	@RequestMapping(value="{roomno}/ajaxRoom.htm", method=RequestMethod.DELETE)
	public String deleteRoom(@PathVariable("roomno") int roomno) {
		
		String str = "";
		
		System.out.println("roomno:" + roomno);
		
		int result = chatservice.deleteRoom(roomno);
	
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//채팅방 입장
	@RequestMapping(value="ajaxEnterRoom.htm/{roomno}", method=RequestMethod.GET)
	public Room enterRoom(@PathVariable("roomno") int roomno) {
		
		Room room = null;
		
		room = chatservice.searchRoom(roomno);
		
		return room;
	}
	
	//채팅방 퇴장
	@RequestMapping(value="exitRoom.htm", method=RequestMethod.POST)
	public String exitRoom(@RequestBody Roominuser roominuser) {
		
		String str = "";
		System.out.println(roominuser.toString());
		int result = chatservice.exitRoom(roominuser);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//기존 메시지 불러오기
	@RequestMapping(value="preRoom.htm", method=RequestMethod.POST)
	public List<Message> preRoom(@RequestBody Message message) {
		
		List<Message> list = chatservice.getMessageListByRoomno(message.getRoomno());
		
		return list;
	}

	//Client가 SEND할 수 있는 경로
	//stompConfig에서 설정한 applicationDestinationPrefixes와 @MessageMapping 경로가 병합됨
	//"/pub/chat/enter"
	@MessageMapping("/chat/enter")
    public void enter(Message message) {
		
		Roominuser roominuser = new Roominuser();
		roominuser.setRoomno(message.getRoomno());
		roominuser.setUserid(message.getUserid());
		
		chatservice.enterRoom(roominuser);
		
		message.setContent(message.getUserid() + "님이 채팅방에 참여하였습니다.");
		template.convertAndSend("/sub/chat/room/" + message.getRoomno(), message);
    }
	
	@MessageMapping(value = "/chat/message")
    public void message(Message message){
		
		chatservice.sendMessage(message);
		
        template.convertAndSend("/sub/chat/room/" + message.getRoomno(), message);
    }
	
	@MessageMapping(value="/chat/note")
	public void note(Message message) {
		
		chatservice.sendMessage(message);
		
		System.out.println("쪽지 보냅니다!");
		
	}
	
}
