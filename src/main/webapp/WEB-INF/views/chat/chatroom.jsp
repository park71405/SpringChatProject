<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
	
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

	<!-- 부트스트랩 아이콘 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

	<link rel="stylesheet" href="resources/css/chatroom.css">
	
	<script type="text/javascript">
	
		$(function(){
			
			let stomp;
			let username = $("#username").html();
			getRoomList();
			connect();
			
			//채팅방 전체 조회
			function getRoomList(){
				$.ajax({
					type: "get",
					url: "ajaxRoom.htm",
					contentType: "application/json; charset=utf-8",
					success: function(data){
						$("#roomlist").empty();
						let html = "";
						$.each(data, function(){
							html += '<li><div class="ps-5 enterroombtn">';
							html += '<input type="hidden" class="roomNo" value="'+this.roomno+'">';
							html += '<h2>'+ this.roomname +'</h2>';
							html += '</div>';
							if(this.host == username){
								html += '<div class="ps-5 deleteroombtn"><h2><i class="bi bi-x-circle"></i></h2></div>';	
							}
							html += '</li>';
						});
						$("#roomlist").append(html);
					}
				});
			}
			
			function connect(){
				let roomno = $("#chat-no").text(); //채팅방 번호
				
				let sockJs = new SockJS("/kosa/chat");
				stomp = Stomp.over(sockJs); //1. SockJS를 내부에 들고있는 stomp를 내어줌
				
				//2. connection이 맺어지면 실행
				stomp.connect({}, function(){
					
					//4. subscribe(path, callback)으로 메세지를 받을 수 있음
					stomp.subscribe("/sub/chat/room/" + roomno, function(chat){
						appendMessage(chat);
					});
					
					//3. send(path, header, message)로 메세지를 보낼 수 있음
					//입장했다는 메시지를 받을 거임
					stomp.send('/pub/chat/enter', {}, JSON.stringify({roomno: roomno, userid: username}));
					
				});
			}
			
			function disconnect(roomno) {
				console.log("연결 중지");
				let requestdata = {"roomno": roomno, "userid": username};
				
				console.log(requestdata);
				
				let data = JSON.stringify(requestdata);
				$.ajax({
					type: "post",
					url: "exitRoom.htm",
					data: data,
					dataType: "text",
					contentType: "application/json; charset=utf-8",
					success: function(data){
						console.log(data);
					}
				});
				stomp.unsubscribe();
			}
			
			//메시지 전송 시 사용하는 함수
			function send(){
				
				let roomno = $("#chat-no").text(); //채팅방 번호
				let msg = $("#inputmessage").val();
				if(msg.trim() != ""){
					let data = JSON.stringify({roomno: roomno, content: msg, userid: username});
					stomp.send('/pub/chat/message', {}, data);
				}
				$("#inputmessage").val("");
			
			}
			
			//메시지 수신 시 html에 동적으로 채팅 추가하는 함수
			function appendMessage(chat){
				
				let message = JSON.parse(chat.body);
				let userid = message.userid;
				
				console.log("message: " + message);
				
				let msgbox;
				if(userid == username){
					msgbox = '<li class="me">';
					msgbox += '<div class="entete">';
					msgbox += '<h3>10:12AM, Today</h3>';
					msgbox += '<h2>'+ username + '</h2>';
					msgbox += '<span class="status blue"></span>';
					msgbox += '</div>';
					msgbox += '<div class="triangle"></div>';
					msgbox += '<div class="message">';
					msgbox += message.content;
					msgbox += '</div>';
					msgbox += '</li>';
				} else {
					msgbox = '<li class="you">';
					msgbox += '<div class="entete">';
					msgbox += '<span class="status green"></span>';
					msgbox += '<h2>'+ userid+'</h2>';
					msgbox += '<h3>10:12AM, Today</h3>';
					msgbox += '</div>';
					msgbox += '<div class="triangle"></div>';
					msgbox += '<div class="message">';
					msgbox += message.content;
					msgbox += '</div>';
					msgbox += '</li>';
				}
				$("#chat").append(msgbox);
				
				let elem = document.getElementById('chat');
				elem.scrollTop = elem.scrollHeight;
				
			}
			
			//메시지 전송
			$(document).on('click', '#sendbtn', function(){
				send();
			});
			
			//채팅방 입장
			$(document).on('click', '.enterroombtn', function(){
				let room1 = $(this).children('.roomNo');
				let roomno = $(room1).val();
				let room2 = $(this).children('h2');
				let roomname = $(room2).text();
				
				$("#realchat").removeClass('visually-hidden');
				$("#emptychat").addClass('visually-hidden');
				
				$("#chat-room").text(roomname);
				$("#chat-no").text(roomno);
				$("#exittext").text("Exit");
				
				let roomno_dis = $("#chat-no").text(); //채팅방 번호
				disconnect(roomno_dis);
				connect();
			});
			
			//채팅방 퇴장
			$(document).on('click', '#exitbtn', function(){
				$("#emptychat").removeClass('visually-hidden');
				let roomno_dis = $("#chat-no").text(); //채팅방 번호
				
				$("#inputmessage").val("");
				$("#realchat").addClass('visually-hidden');
				
				$("#chat-room").text("");
				$("#chat-no").text("");
				$("#exittext").text("");
				
				disconnect(roomno_dis);
			});
			
			//채팅방 개설
			$(document).on('click', '#createRoombtn', function(){
				let requestdata = {
						"roomname" : $("#createRoominput").val(),
						"host": username
				}
				let data = JSON.stringify(requestdata);
				$.ajax({
					type: "post",
					url: "ajaxRoom.htm",
					data: data,
					dataType: "text",
					contentType: "application/json; charset=utf-8",
					success: function(data){
						$("#createRoominput").val("");
						getRoomList();
					}
				});
			});
			
			//채팅방 삭제
			$(document).on('click', '.deleteroombtn', function(){
				let parent = $(this).closest('li');
				let ch = $(parent).children('div');
				let roomno1 = $(ch).children('.roomNo');
				let roomno = $(roomno1).val();
				
				let roomno_dis = $("#chat-no").text(); //채팅방 번호
				disconnect(roomno_dis);
				
				$.ajax({
					type: "DELETE",
					url:roomno+"/ajaxRoom.htm",
					success: function(data){
						getRoomList();
					}
				});
			});
			
		});
	
	</script>
	
</head>
<body>

	<se:authentication property="name" var="loginuser"/>
	<p id="username" class="visually-hidden">${loginuser}</p>

	<div id="container">
		<aside>
			<header class="row">
				<input class="col-8" type="text" id="createRoominput" placeholder="채팅방 만들기">
				<button class="col-4" id="createRoombtn"><h4><i class="bi bi-plus-square"></i></h4></button>
			</header>
			<ul id="roomlist">
				<c:forEach var="room" items="${list}">
					<li>
						<div class="ps-5 enterroombtn">
							<input type="hidden" class="roomNo" value="${room.roomno}">
							<h2>${room.roomname}</h2>
						</div>
						<div class="ps-5 deleteroombtn">
							<h2><i class="bi bi-x-circle"></i></h2>
						</div>
					</li>
				</c:forEach>
			</ul>
		</aside>
		
		<main>
			<header>
				<div class="row">
					<div class="col-8">
						<h2 id="chat-room"></h2>
						<h3 id="chat-no" class="visually-hidden"></h3>
					</div>
					<div class="col-2" id="exitbtn"> 
						<h2 id="exittext"></h2>
					</div>
				</div>
			</header>
			
			<div id="emptychat">
				<ul id="chat1" class="">
				</ul>
			</div>
			
			<div id="realchat" class="visually-hidden">
				<ul id="chat">
					<li class="you">
						<div class="entete">
							<span class="status green"></span>
							<h2>Vincent</h2>
							<h3>10:12AM, Today</h3>
						</div>
						<div class="triangle"></div>
						<div class="message">
							여기는 메시지 내용 적는 부분입니다!!!!	
						</div>
					</li>
					<li class="me">
						<div class="entete">
							<h3>10:12AM, Today</h3>
							<h2>Vincent</h2>
							<span class="status blue"></span>
						</div>
						<div class="triangle"></div>
						<div class="message">
							여기도 메시지 적는 부분인데 이제 내가 보낸 메시지 나타날거임!!!!
						</div>
					</li>
				</ul>
				
				<footer>
					<textarea id="inputmessage" placeholder="Type your message"></textarea>
					<a href="#" id="sendbtn">Send</a>
				</footer>
			</div>
			
			
		
		</main>
		
	</div>

</body>
</html>