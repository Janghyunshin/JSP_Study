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

<%@ include file = "dbconn_oracle.jsp"  %>

<% 

	request.setCharacterEncoding("UTF-8"); 	// 한글 깨지지 않도록 처리 , EUC-KR, UTF-8
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null; 
    ResultSet rs = null; 	// select 한 결과를 담는 객체, Select한 레코드셋을 담고 있다.
    String sql = null; 	// 전역변수
	
    try {
    // 레코드 삭제 , 폼에서 넘긴 ID, Passwd와 DB의 ID,Passwd가 일치할때 레코드제거
    	sql = "select id, pass from mbTbl where id = '" +id+ "' ";
    	stmt = conn.createStatement();
    	rs = stmt.executeQuery(sql);
    	
    	if(rs.next()) { 	// ID가 존재할 떄
    		// rs의 결과 레코드를 변수에 할당
			String rId = rs.getString("id");
    		String rPass = rs.getString("pass");
    		
    		// 패스워드가 일치하는지 확인 
    		if (passwd.equals(rPass)) { 	// 폼의 password와 DB의 Password가 일치할때
    			sql = "delete mbTbl where id = '" +id+ "' ";
    			stmt.executeUpdate(sql);
    			
    			out.println ("테이블에서 해당 아이디  : " + id + " 가 잘 삭제 되었습니다. ");
			//   out.println(sql);
    		
    		} else {	// 폼의 password와 DB의 Password가 일치하지 않을때
    			out.println("패스워드가 일치 하지 않습니다.");
    		}
    		
    		
    	} else { 	//ID가 존재하지 않을 때 
    		out.println ("해당 아이디는 존재하지 않습니다.");
    	}
    
    } catch (Exception ex) {
    	out.println (ex.getMessage());
    	
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