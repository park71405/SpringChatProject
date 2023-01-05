package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import service.KanbanService;
import vo.Kanban;

@RestController 
@RequestMapping("/kanban")
public class KanbanController {

	private KanbanService kanbanservice;
	
	@Autowired
	public void setKanbanservice(KanbanService kanbanservice) {
		this.kanbanservice = kanbanservice;
	}
	
	//칸반보드 전체 조회
	@RequestMapping(value="", method=RequestMethod.GET)
	public List<Kanban> kanbanList(){
		
		List<Kanban> list = kanbanservice.getKanbanList();
		
		return list;
	}

	//칸반보드 일정 등록
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String insertKanban(@RequestBody Kanban kanban) {
		
		String str = "";
		
		int result = kanbanservice.insertKanban(kanban);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//칸반보드 일정 수정
	@RequestMapping(value="/", method=RequestMethod.PUT)
	public String updateKanban(@RequestBody Kanban kanban) {
		
		String str = "";
		
		int result = kanbanservice.updateKanban(kanban);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//칸반보드 위치 변경
	@RequestMapping(value="/updateLocation.htm", method=RequestMethod.PUT)
	public String updateLocation(@RequestBody Kanban kanban) {
		String str = "";
		
		int result = kanbanservice.updateLocation(kanban);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
	//칸반보드 일정 삭제
	@RequestMapping(value="{k_no}/", method=RequestMethod.DELETE)
	public String deleteKanban(@PathVariable("k_no") int k_no) {
		
		String str = "";
		
		int result = kanbanservice.deleteKanban(k_no);
		
		if(result > 0) {
			str = "success";
		}else {
			str = "false";
		}
		
		return str;
	}
	
}
