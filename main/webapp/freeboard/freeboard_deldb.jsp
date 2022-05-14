<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ include file = "dbconn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href = "filegb.css" rel = "stylesheet" type ="text/css">
<title> 글 삭제 ( 실제 DataBase에 삭제를 처리하는 페이지 )</title>
</head>
<body>
[ <a href = "freeboard_list.jsp?go=<%= request.getParameter("page") %> "> 게시판 목록으로 이동 </a>]

<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt = 0;					// delete가 잘되었는지 확인하는 변수
	
	int id = Integer.parseInt(request.getParameter("id"));

	try {
		sql = "select * from freeboard where id = ? "; 		// DB의 비밀번호와 폼으로 넘겨온 비밀번호 확인
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		
		if ( !(rs.next())) { 	// 아이디가 존재하지 않는 경우
			out.println("해당 내용은 존재하지 않습니다. ");
		} else {
			// 아이디가 존재하는 경우 : password를 확인후 맞으면 삭제
			String pwd = rs.getString("password");
			
			if (pwd.equals(request.getParameter("password"))) {
				sql = "delete freeboard where id = ? " ;
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				cnt = pstmt.executeUpdate();
				
				if (cnt > 0) {
					out.println ("해당 내용은 잘 삭제되었습니다. ");
					
				} else {
					out.println ("해당 내용은 삭제되지 않았습니다.");
				}
				
			} else {
				out.println ("비밀번호가 틀렸습니다.");
			}
			
		}
		
		
	} catch (Exception ex){
		out.println(ex); 	// ex.getmessage(); 찍어도됨
		
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	
%>

</body>
</html>