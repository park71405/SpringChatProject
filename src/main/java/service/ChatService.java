package service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.KanbanDao;
import dao.RoomDao;
import vo.Room;
import vo.Roominuser;

@Service
public class ChatService {

	// Mybatis 작업
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	// 전체 채팅 방 조회
	public List<Room> getRoomList() {
		List<Room> list = null;
		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			list = roomdao.getRoomList();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 채팅방 개설
	public int insertRoom(Room room) {
		int result = 0;

		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			result = roomdao.insertRoom(room);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	// 채팅방 삭제
	public int deleteRoom(int roomno) {
		int result = 0;

		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			result = roomdao.deleteRoom(roomno);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	// 채팅방 검색
	public Room searchRoom(int roomno) {
		Room room = null;

		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			room = roomdao.searchRoom(roomno);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return room;
	}
	
	//채팅방 입장
	public int enterRoom(Roominuser roominuser) {
		int result = 0;

		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			
			int tmp_result = roomdao.enterCheck(roominuser);
			
			if(tmp_result == 0) {
				result = roomdao.enterRoom(roominuser);
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	//채팅방 퇴장
	public int exitRoom(Roominuser roominuser) {
		int result = 0;

		try {

			RoomDao roomdao = sqlsession.getMapper(RoomDao.class);
			result = roomdao.exitRoom(roominuser);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	
}
