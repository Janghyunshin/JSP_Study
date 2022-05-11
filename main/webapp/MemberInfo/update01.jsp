<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update를 통한 데이터 수정</title>
</head>
<body>

	<form method="post" action = "update01_process.jsp">
		<p> 아이디 : <input type ="text" name="id">			<!-- <p> 닫아도 되고 열어놓아도 되고 -->
		<p> 패스워드 : <input type ="password" name="passwd">
		<p> 이름 : <input type ="text" name="name">
		<p> 이메일 : <input type="text" name="email">
		<p> <input type ="submit" values ="전송">
		<!-- 값을 입력하고 submit이 되면 맨위에 있는 action 페이지를 호출하게되고 값을 넣게된다  -->
		
	</form>
</body>
</html>