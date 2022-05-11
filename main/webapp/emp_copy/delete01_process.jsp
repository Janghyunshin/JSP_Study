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
	
	// 폼에서 넘겨받은 ENO, DNO가 DB에서 가져온 ENO,DNO 와 확인해서 같으면 delete를 실행하고 다르면 delete 하지 않는다.
	try {
		sql = "select eno,dno from emp_copy where eno = '" +eno+ "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) { // eno가 일치시
    		// rs의 결과 레코드를 변수에 할당
			String rEno = rs.getString("eno");
    		String rDno = rs.getString("dno");
    		
    		// DNO의 일치여부 확인
    		if (dno.equals(rDno)) { // dno가 일치시
    			sql = "delete emp_copy where eno = '"+eno+"' ";
    			stmt.executeUpdate(sql);
    			
    			out.println("테이블에서 " + eno + " 해당 사원이 잘 삭제 되었습니다.");
    		
    		} else { // dno가 일치하지 않을때
    			out.println("dno가 일치하지 않습니다.");
    		}
    		
    		// eno가 일치하지 않을 시
		} else {
			out.println(eno + ": 이 사원번호가 일치하지 않습니다.");
		}
		
	} catch (Exception ex) {
		out.println(ex.getMessage());
	} finally {
		if (stmt != null)
			stmt.close();
		if (rs != null)
			rs.close();
		if (conn != null)
			conn.close();
	}
	
	
%>

</body>
</html>