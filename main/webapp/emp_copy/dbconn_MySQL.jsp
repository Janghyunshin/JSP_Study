<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MSSQL DB Connection </title>
</head>
<body>

<%
	// 변수 초기화
	Connection conn = null; 	// DB를 연결하는 객체
	String driver = "com.mysql.jdbc.Driver";		// Mysql Driver에 접속
	String url = "jdbc:mysql://localhost:3306/mydb";
	
		Class.forName (driver); 	// 오라클 드라이버 로드
		conn = DriverManager.getConnection (url, "root", "1234");
		
%>

</body>
</html>