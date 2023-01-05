package service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.EmpDao;
import vo.Emp;

@Service
public class EmpService {
	
	//Mybatis 작업
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	//전체목록 조회
	public List<Emp> getEmpAllList(){
		List<Emp> list = null;
		try {
				//동기화/////////////////////////////////////////////////////
			 	EmpDao empdao = sqlsession.getMapper(EmpDao.class);
				///////////////////////////////////////////////////////////
			 	list = empdao.getEmpAllList();
		} catch (ClassNotFoundException e) {
					e.printStackTrace();
		} catch (SQLException e) {
					e.printStackTrace();
		}
		return list;
	}
	
	//조건조회
	public Emp getDetailEmp(String empno) {
		Emp emp = null;
		try {
			//동기화/////////////////////////////////////////////////////
		 	EmpDao empdao = sqlsession.getMapper(EmpDao.class);
			///////////////////////////////////////////////////////////
			emp = empdao.getDetailEmp(empno);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return emp;
	}
	
	//삽입
	public String insertEmp(Emp emp) {
		try {
			EmpDao empdao = sqlsession.getMapper(EmpDao.class);
			empdao.insertEmp(emp);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return "redirect:emp.htm";
	}
	
	//수정 서비스
	public Emp updateEmp(String empno) {
		Emp emp = null;
		try {
			EmpDao empdao = sqlsession.getMapper(EmpDao.class);
			emp = empdao.getDetailEmp(empno);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return emp;
	}
	
	//수정하기 처리
	public String updateEmp(Emp emp) {
		EmpDao empdao = sqlsession.getMapper(EmpDao.class);
		try {
			empdao.updateEmp(emp);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return "redirect:empDetail.htm?empno="+emp.getEmpno();
	}
	
	
	//삭제 
	public String empDel(String empno) {
		EmpDao empdao = sqlsession.getMapper(EmpDao.class);
		try {
			empdao.deleteEmp(empno);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return "redirect:emp.htm";
	}
	
	
}
