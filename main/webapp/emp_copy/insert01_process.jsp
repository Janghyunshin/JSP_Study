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
	request.setCharacterEncoding("UTF-8");

	String eno = request.getParameter("eno");	
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	Statement stmt = null;
	
	try {
		String sql = "INSERT INTO emp_copy (eno, ename, job, manager, hiredate, salary, commission, dno)values('"+eno+"', '"+ename+"', '"+job+"', '"+manager+"', '"+hiredate+"', '"+salary+"', '"+commission+"', '"+dno+"')";
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		out.println("테이블 삽입에 성공 했습니다. ");
		
	} catch (Exception e) {
		out.println("emp_copy 테이블 삽입을 실패 했습니다.");
		out.println(e.getMessage());
		
	} finally {
		if(stmt != null)
			stmt.close();
		if(conn !=null)
			conn.close();
	}
	
	
%>

<%= eno %> <p>
<%= ename %> <p>
<%= job %> <p>
<%= manager %> <p>
<%= hiredate %> <p>
<%= salary %> <p>
<%= commission %> <p>
<%= dno %>

</body>
</html>