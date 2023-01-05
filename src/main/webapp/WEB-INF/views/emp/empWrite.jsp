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
	
	<form action="empWrite.htm" method="post">
	<table class="table table-striped">
		<thead>
		  <tr>
		    <th>EMPNO</th>
		    <th><input type="text" name="empno" value="" required /></th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td>ENAME</td>
		    <td><input type="text" name="ename" value="" /></td>
		  </tr>
		  <tr>
		    <td>JOB</td>
		    <td><input type="text" name="job" value="" /></td>
		  </tr>
		  <tr>
		    <td>MGR</td>
		    <td><input type="text" name="mgr" value="" /></td>
		  </tr>
		  <tr>
		    <td>HIREDATE</td>
		    <td><input type="text" name="hiredate" value="" /></td>
		  </tr>
		  <tr>
		    <td>SAL</td>
		    <td><input type="text" name="sal" value="" /></td>
		  </tr>
		  <tr>
		    <td>COMM</td>
		    <td><input type="text" name="comm" value="" /></td>
		  </tr>
		  <tr>
		    <td>DEPTNO</td>
		    <td><input type="text" name="deptno" value="" /></td>
		  </tr>
		</tbody>
	</table>
	<input class="btn btn-primary" type="submit" value="추가하기" />
	</form>
	<a class="btn btn-success" href="${pageContext.request.contextPath}/emp/emp.htm">목록가기</a>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>