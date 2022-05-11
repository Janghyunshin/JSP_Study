<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file="dbconn_oracle.jsp" %>

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
	
	// 전역변수 선언
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	
	// 폼에서 넘겨받은 ENO, DNO가 DB에서 가져온 ENO,DNO 와 확인해서 같으면 Update를 실행하고 다르면 Update 하지 않는다.
	try {
		sql = "select eno, dno from emp_copy where eno = '" +eno+ "' ";
		stmt = conn.createStatement();
		
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			String rEno = rs.getString("eno");
			String rDno = rs.getString("dno");
			
			// Eno와 Dno의 값이 같으면 salary, commission 의 값을 업데이트 한다.
			if (eno.equals(rEno) && dno.equals(rDno)) {
				sql = "update emp_copy set salary = '" +salary+ "', commission = '" +commission+"' where eno = '" +eno+ "'";
				stmt.executeUpdate(sql);
				out.println("테이블의 내용이 잘 수정되었습니다.");
				
			} else { 
				out.println("부서번호가 일치하지 않습니다");
			}
			
		} else {
			out.println(eno + " : 해당 사원번호가 데이터 베이스에 존재하지 않습니다.");
		}
		
		
	} catch (Exception ex) {
		out.println(ex.getMessage());
		
	} finally {
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (conn != null)
			conn.close();
	}
	



%>
</body>
</html>