package dao;

import java.sql.SQLException;
import java.util.List;

import vo.Kanban;

public interface KanbanDao {

	//전체 조회
	List<Kanban> getKanbanList() throws ClassNotFoundException, SQLException;
	
	//일정 수정
	public int updateKanban(Kanban k) throws ClassNotFoundException, SQLException;
	
	//일정 위치 수정
	public int updateLocation(Kanban k) throws ClassNotFoundException, SQLException;
	
	//일정 삭제
	public int deleteKanban(int k_no) throws ClassNotFoundException, SQLException;
	
	//일정 생성
	public int insertKanban(Kanban k) throws ClassNotFoundException, SQLException;
	
}
