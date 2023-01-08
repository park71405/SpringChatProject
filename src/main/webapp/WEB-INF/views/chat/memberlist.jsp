<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>

	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">

	<link rel="stylesheet" href="resources/css/memberlist.css">

	<script type="text/javascript">
	
		$(function(){
			
			let stomp;
			let username = $("#username").html();
			connect();
			
			//연결
			function connect(){
				let sockJs = new SockJS("/kosa/chat");
				stomp = Stomp.over(sockJs); 
				
				stomp.connect({}, function(){
					stomp.subscribe("/sub/chat/userid/"+username, function(chat){
						console.log("구독해셔 메시지가 온겨 그런겨");
						console.log(chat);
					});
				});
			}
			
			//메시지 전송
			function send(to_member){
				let msg = $("#message").val();
				if(msg.trim() != ""){
					let data = JSON.stringify({
						content: msg,
						userid: username,
						to_userid: to_member,
						roomno: 0
					});
					stomp.send('/pub/chat/note', {}, data);
				}
				$("#to_mem").html("");
				$("#message").val("");
				$("#page-wrapper").addClass('visually-hidden');
			}
			
			//Send Message 버튼 클릭
			$(document).on('click', '#mysend', function(){
				
				let divtag = $(this).closest("#page-wrapper");
				let ch = $(divtag).children("#to_mem");
				let text = $(ch).html();
				
				let sp = text.split(":");
				
				let userid = sp[1].trim();
				
				send(userid);
				
			});
			
			//쪽지 보내기 버튼 클릭
			$(document).on('click', '.btn', function(){
				
				let to_member = $(this).attr('value2');
				
				//메시지 창 띄우기
				$("#page-wrapper").removeClass('visually-hidden');
				$("#to_mem").html("To : " + to_member);
				
			});
			
			//쪽지 창의 Close 버튼 클릭
			$(document).on('click', '#myclose', function(){
				$("#to_mem").html("");
				$("#message").val("");
				$("#page-wrapper").addClass('visually-hidden');
			});
			
		});
	
	</script>

</head>
<body>

	<se:authentication property="name" var="loginuser" />
	<p id="username" class="visually-hidden">${loginuser}</p>

	<div id="page-wrapper" class="visually-hidden">

		<div id="to_mem">Connecting...</div>

		<ul id="messages"></ul>

		<div id="message-form" >
			<textarea id="message" placeholder="Write your message here..."
				required></textarea>
			<button id="mysend" type="submit">Send Message</button>
			<button type="button" id="myclose">Close Connection</button>
		</div>
	</div>

	<table class="table table-striped m-3 p-5">
		<thead>
			<tr>
				<th>USERID</th>
				<th>NAME</th>
				<th></th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${list}" var="l">
				<c:if test="${l.userid != loginuser && l.userid != 'all'}">
					<tr>
						<td>${l.userid}</td>
						<td>${l.name}</td>
						<td><button class="btn" type="button" value2="${l.userid}">쪽지보내기</button>
						</td>
					</tr>
				</c:if>
			</c:forEach>

		</tbody>
	</table>

</body>
</html>