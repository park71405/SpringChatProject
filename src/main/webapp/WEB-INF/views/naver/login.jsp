<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

</head>
<body>

	<div>
		<a href="${naverAuthUrl}"> <img width="230" height="53"
			src="resources/images/naverLogin.png">
		</a>
	</div>

	 <!-- 네이버 로그인 버튼 노출 영역 -->
	<!--	<div id="naver_id_login"></div>
		//네이버 로그인 버튼 노출 영역
		<script type="text/javascript">
			var naver_id_login = new naver_id_login("ZVsCtV_60QE11eaDVuBk",
					"http://192.168.0.156:8090/naver/loginPostNaver.htm");
			var state = naver_id_login.getUniqState();
			naver_id_login.setButton("white", 2, 40);
			naver_id_login
					.setDomain("http://192.168.0.156:8090/kosa/naver/login.htm");
			naver_id_login.setState(state);
			naver_id_login.setPopup();
			naver_id_login.init_naver_id_login();
		</script>
		-->
</body>
</html>