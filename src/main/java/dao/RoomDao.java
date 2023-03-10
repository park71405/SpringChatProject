package dao;

import java.sql.SQLException;
import java.util.List;

import vo.Message;
import vo.Room;
import vo.Roominuser;

public interface RoomDao {
	
	//방 생성
	int insertRoom(Room room) throws ClassNotFoundException, SQLException;
	
	//전체 방 불러오기
	List<Room> getRoomList() throws ClassNotFoundException, SQLException;
	
	//방 삭제
	int deleteRoom(int roomno) throws ClassNotFoundException, SQLException;

	//채팅방 검색
	Room searchRoom(int roomno) throws ClassNotFoundException, SQLException;
	
	//채팅방 입장 전 중복 검사
	int enterCheck(Roominuser roominuser) throws ClassNotFoundException, SQLException;
	
	//채팅방 입장
	int enterRoom(Roominuser roominuser) throws ClassNotFoundException, SQLException;
	
	//채팅방 퇴장
	int exitRoom(Roominuser roominuser) throws ClassNotFoundException, SQLException;

	//메시지 추가
	int sendMessage(Message message) throws ClassNotFoundException, SQLException;
	
	//해당 방의 기존 메시지 읽어오기
	List<Message> getMessageListByRoomno(int roomno) throws ClassNotFoundException, SQLException;
	
	//쪽지 읽기
	List<Message> getNoteByUserid(String to_userid) throws ClassNotFoundException, SQLException;
	
	//쪽지 읽음 처리
	int readNote(String to_userid) throws ClassNotFoundException, SQLException;
	
}
