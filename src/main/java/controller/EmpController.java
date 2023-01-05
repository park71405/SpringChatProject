package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import service.EmpService;
import vo.Emp;

@Controller
@RequestMapping("/emp/")
public class EmpController {

	private EmpService empservice;

	@Autowired
	public void setEmpservice(EmpService empservice) {
		this.empservice = empservice;
	}
		
	// 전체조회
	@RequestMapping("emp.htm")
	public String empList(Model model) {

		List<Emp> list = empservice.getEmpAllList();
		model.addAttribute("list", list);
		return "emp/empList";

	}

	// 조건조회
	@RequestMapping("empSearch.htm")
	public String empSearch(String empno, Model model) {
		Emp emp = empservice.getDetailEmp(empno);
		model.addAttribute("emp", emp);
		return "emp/empDetail";
	}

	// 상세보기
	@RequestMapping("empDetail.htm")
	public String empDetail(String empno, Model model) {

		Emp emp = empservice.getDetailEmp(empno);
		model.addAttribute("emp", emp);
		return "emp/empDetail";
	}

	// 추가하기
	@GetMapping(value = "empWrite.htm")
	public String empWrite() {
		return "emp/empWrite";
	}

	// 추가하기 처리 서비스
	@PostMapping("empWrite.htm")
	public String empWrite(Emp emp) {
		return empservice.insertEmp(emp);
	}

	// 수정하기
	@GetMapping(value = "empEdit.htm")
	public String empEdit(String empno, Model model) {
		Emp emp = null;
		try {
			emp = empservice.updateEmp(empno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("emp", emp);
		return "emp/empEdit";
	}

	// 수정 처리
	@PostMapping("empEdit.htm")
	public String empEdit(Emp emp) {
		return empservice.updateEmp(emp);
	}

	// 삭제 하기
	@RequestMapping("empDel.htm")
	public String empDel(String empno) {
		
		return empservice.empDel(empno);
	}
	
}
