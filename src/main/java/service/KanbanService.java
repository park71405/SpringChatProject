package service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.KanbanDao;
import vo.Kanban;

@Service
public class KanbanService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	//전체 조회
	public List<Kanban> getKanbanList(){
		List<Kanban> list = null;
		
		try {
			KanbanDao kanbandao = sqlsession.getMapper(KanbanDao.class);
			list = kanbandao.getKanbanList();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//삽입
	public int insertKanban(Kanban kanban) {
		int result = 0;
		
		try {
			
			KanbanDao kanbandao = sqlsession.getMapper(KanbanDao.class);
			result = kanbandao.insertKanban(kanban);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//수정
	public int updateKanban(Kanban kanban) {
		int result = 0;
		
		try {
			
			KanbanDao kanbandao = sqlsession.getMapper(KanbanDao.class);
			result = kanbandao.updateKanban(kanban);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//일정 위치 수정
	public int updateLocation(Kanban kanban) {
		int result = 0;
		
		try {
			
			KanbanDao kanbandao = sqlsession.getMapper(KanbanDao.class);
			result = kanbandao.updateLocation(kanban);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//삭제
	public int deleteKanban(int k_no) {
		int result =0;
		
		try {
			
			KanbanDao kanbandao = sqlsession.getMapper(KanbanDao.class);
			result = kanbandao.deleteKanban(k_no);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
}
