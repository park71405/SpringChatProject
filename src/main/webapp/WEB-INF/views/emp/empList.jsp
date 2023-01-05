<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/header.jsp" />
	
	<table class="table table-striped">
		<thead>
		  <tr>
		    <th>사원번호로 검색 : <form action="empSearch.htm" method="post"><input type="text" name="empno"><input type="submit" value="검색"></form></th>
		    <th><a class="btn btn-primary" href="${pageContext.request.contextPath}/emp/empWrite.htm">사원 등록</a></th>
		   </tr>
		 </thead>
	</table>

	<table class="table table-striped">
		<thead>
		  <tr>
		    <th>EMPNO</th>
		    <th>ENAME</th>
		    <th>JOB</th>
		    <th>MGR</th>
		    <th>HIREDATE</th>
		    <th>SAL</th>
		    <th>COMM</th>
		    <th>DEPTNO</th>
		    <th>수정/삭제</th>
		  </tr>
		</thead>
		<tbody>
		  
		  <c:forEach items="${list}" var="l">
		  <tr>
		    <td>${l.empno}</td>
		    <td>${l.ename}</td>
		    <td>${l.job}</td>
		    <td>${l.mgr}</td>
		    <td>${l.hiredate}</td>
		    <td>${l.sal}</td>
		    <td>${l.comm}</td>
		    <td>${l.deptno}</td>
		    <td>
		    <a href="${pageContext.request.contextPath}/emp/empDetail.htm?empno=${l.empno}">상세보기</a>
		    </td>
		   </tr>
		  </c:forEach>
		  
		</tbody>
	</table>
	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>