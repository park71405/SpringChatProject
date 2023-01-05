<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="${pageContext.request.contextPath}/index.htm">메인화면</a><br>
	<hr />
	<a href="${pageContext.request.contextPath}/emp/emp.htm">전체조회</a><br>
	<hr />
	<a href="${pageContext.request.contextPath}/kanban.htm">칸반보드</a><br>
	<hr />
	<a href="${pagecontext.request.contextPath}/vision/extractTextView.htm">비전 API 문자열 추출(...ing)</a><br>
	<a href="${pageContext.request.contextPath}/Deeplearning.htm">딥러닝(...ing)</a><br>
	<hr />
	<a href="${pageContext.request.contextPath}/joinus/join.htm">회원가입</a><br>
	<a href="${pageContext.request.contextPath}/joinus/login.htm">로그인</a><br>
	<se:authentication property="name" var="loginuser"/>
	<se:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
		<a href="${pageContext.request.contextPath}/logout">${loginuser}로그아웃</a>
	</se:authorize>
	<hr />
	<a href="${pageContext.request.contextPath}/chatroom.htm">채팅 방 입장</a><br>
	
</body>
</html>