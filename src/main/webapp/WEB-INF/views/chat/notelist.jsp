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
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
	
	<script type="text/javascript">
	
		$(function(){
			
			let username = $("#username").html();
			
			function read(){
				let requestdata = {"to_userid": username};
				
				let data = JSON.stringify(requestdata);
				$.ajax({
					type: "post",
					url: "noteread.htm",
					data: data,
					dataType: "text",
					contentType: "application/json; charset=utf-8",
					success: function(data){
						console.log(data);
					}
				});	
			}
			
			$(document).on('click', '#btn', function(){
				read();
			})
			
		});
	
	</script>

</head>
<body>

	<se:authentication property="name" var="loginuser"/>
	<p id="username" class="visually-hidden">${loginuser}</p>

	<button type="button" id="btn" class="btn btn-outline-dark">쪽지 확인</button>

	<table class="table table-striped m-3 p-5">
		<thead>
			<tr>
				<th>From</th>
				<th>내용</th>
				<th><i class="bi bi-clock"></i></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="l">
				<tr>
					<td>${l.userid}</td>
					<td>${l.content}</td>
					<td>${l.messagedate}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>

</body>
</html>