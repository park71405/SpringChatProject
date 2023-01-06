package vo;

import lombok.Data;

@Data
public class Message {

	int messageno;
	String content;
	String userid;
	String to_userid;
	int roomno;
	int m_check; //메시지를 읽었는지 안읽었는지 여부
	String messagedate;
	
}
