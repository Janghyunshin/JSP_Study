<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file = "dbconn_MySQL.jsp" %>

<table width = "500" border = "1"> 
	<tr>
		<th> eno </th>
		<th> ename </th>
		<th> job </th>
		<th> manager </th>
		<th> hiredate </th>
		<th> salary </th>
		<th> commission </th>
		<th> dno </th>
	</tr>

<%
		ResultSet rs = null;	// ResultSet 객체는 DB의 테이블을 Select 해서 나온 결과 레코드셋을 담는 객체
		Statement stmt = null;	// SQL 쿼리를 담아서 실행하는 객체
	
		try {
			String sql = "SELECT * FROM emp_copy ";
			stmt = conn.createStatement();		// connection 객체의 createStatement()로 stmt를 활성화
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String eno = rs.getString("eno");
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				String manager = rs.getString("manager");
				String hiredate = rs.getString("hiredate");
				String salary = rs.getString("salary");	
				String commission = rs.getString("commission");
				String dno = rs.getString("dno");	
			
		%>
		
			<tr>
				<td> <%= eno %> </td>
				<td> <%= ename %> </td>
				<td> <%= job %> </td>
				<td> <%= manager %> </td>
				<td> <%= hiredate %> </td>
				<td> <%= salary %> </td>
				<td> <%= commission %> </td>
				<td> <%= dno %> </td>
			</tr>			
		
			<% 
			}
			
		} catch (Exception e) {
			out.println ("테이블을 호출하는데 실패했습니다.");
			out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn!= null)
				conn.close();
		}

		%>
		</table>
</body>
</html>