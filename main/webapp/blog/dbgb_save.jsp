<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*, java.util.*, java.text.*" %>    
<% request.setCharacterEncoding("EUC-KR"); %>    <!-- 한글 처리 -->
<%@ include file = "dbconn_oracle.jsp" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>폼의 값을 받아서 DataBase에 값을 넣어주는 파일</title>
</head>
<body>
<%	// 폼에서 넘긴 변수 저장
	String na = request.getParameter("name");				// 이름
	String em = request.getParameter("email");				// 이메일
	String sub = request.getParameter("subject");			// 제목
	String cont = request.getParameter("content");			// 내용
	
	int id = 1;		// DB의 id컬럼에 저장할 값.
	
	int pos = 0;
	if (cont.length() ==1) {
		cont = cont + " " ;
	}
	
	while ((pos = cont.indexOf("\'", pos)) != -1) { 	// -1 값이 존재하지 않을때
		String left = cont.substring (0,pos);
			//out.println ("pos : " + pos + "<p>");
			//out.println ("left : " + left + "<p>");
			
		String right = cont.substring (pos, cont.length());
			//out.println ("right : " +right + "<p>");
			
		cont = left + "\'" + right;
		pos += 2;
	}
	
	// 오늘의 날짜 처리
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyy.MM.dd a h:mm");
	String ymd = myformat.format(yymmdd);
	
	// 전역변수
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0; 			// Insert 가 잘 되었는지 그렇지 않은지 확인하는 변수 
	
	try {
			// 값을 저장하기 전에 최신 글번호를 (max(id))를 가져 와서  + 1 을 적용한다.
			// conn (Connection) : Auto commit; 이 작동 된다.
				//commit을 명시 하지 않아도 insert, update, delete, 자동 커밋이 된다.
				
			st = conn.createStatement();
			sql = "select * from guestboard";
			rs = st.executeQuery(sql);

		sql = "insert into guestboard (name, email, inputdate, subject, content)";
		sql = sql + "values ('" +na+ "','" +em+ "', '" +ymd+ "','" +sub+ "','" +cont+ "')";
		
		cnt = st.executeUpdate(sql);	// cnt > 0 : Insert 성공
		out.println(sql);
		
		if (cnt > 0 ) {
			out.println("데이터가 성공적으로 입력 되었습니다.");
		} else {
			out.println("데이터가 입력되지 않았습니다.");
		}
		
	} catch (Exception ex) {
		out.println(ex);
	} finally {
		if (rs != null)
			rs.close();
		if (st != null)
			st.close();
		if (conn != null)
			conn.close();
	}
	
%>

<jsp:forward page = "dbgb_show.jsp" /> 	

<!-- 페이지 이동 
	
	jsp:forward 			: 서버단에서 페이지를 이동, 클라이언트의 기존의 URL 정보가 바뀌지 않는다.
	response.sendRedirect	: 
		클라이언트에서 페이지를 재요청으로 페이지 이동, 이동하는 페이지로 URL 정보가 바뀐다.

 -->
 
</body>
</html>