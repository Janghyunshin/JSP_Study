<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update here</title>
</head>
<body>
	<form method= "post" action = "update01_process.jsp">
		<p> 사원번호 : <input type ="number" name= "eno">			<!-- <p> 닫아도 되고 열어놓아도 되고 -->
		<p> 사원명 : <input type ="text" name= "ename">
		<p> 직책 : <input type ="text" name="job">
		<p> 직속상관 : <input type="number" name="manager">
		<p> 입사일 : <input type="date" name="hiredate">
		<p> 급여 : <input type="number" name="salary">
		<p> 보너스 : <input type="number" name="commission">
		<p> 부서번호 : <input type="number" name="dno">
		<p> <input type ="submit" value ="전송">
		<!-- 값을 입력하고 submit이 되면 맨위에 있는 action 페이지를 호출하게되고 값을 넣게된다  -->
	</form>
	
</body>
</html>