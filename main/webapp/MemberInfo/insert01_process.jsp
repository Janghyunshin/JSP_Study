<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼에서 넘겨 받은 값을 DB에 저장하는 파일</title>
</head>
<body>

<%@ include file="dbconn_oracle.jsp" %> <!--이 파일의 코드가 그대로 들어와있다고 생각하면됨  -->

<%
	request.setCharacterEncoding("UTF-8");	//폼에서 넘긴 한글처리하기 위함
	String id = request.getParameter("id");	//request.getParameter은 Insert01의 form에서 값을 받아오온다
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null;		//Statement 객체 : SQL 쿼리 구문을 담아서 실행하는 객체
	
	try{
		String sql = "INSERT INTO mbTbl(idx, id, pass, name, email)Values(seq_mbTbl_idx.nextval,'"+id+"', '"+passwd+"', '"+name+"', '"+email+"')";
		stmt = conn.createStatement();	//connection 객체를 통해서 statement 객체 생성
		//conn은 dbconn_oracle.jsp에서 생성한 객체
		stmt.executeUpdate(sql);		//statement 객체를 통해서 sql을 실햄함.
				//stmt.excuteUpdate (sql) : sql<== Insert, Update, Delete 문이 온다 
				//stmt.excuteQuery (sql) : sql <== select 문이 오면서 결과를 Resultset 객체로 반환
		out.println("테이블 삽입에 성공 했습니다. ");

	}catch (SQLException e){
		out.println("mbTbl 테이블 삽입을 실패 했습니다.");
		out.println(e.getMessage());
		
	}finally {
		if(stmt != null)
			stmt.close();
		if(conn !=null)
			conn.close();
	}
	
	
%>

<p><p><p>
<%= id %> <p>
<%= passwd %> <p>
<%= name %> <p>
<%= email %>


</body>
</html>