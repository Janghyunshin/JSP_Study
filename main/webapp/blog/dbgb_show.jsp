<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>    <!-- 한글 처리 -->
<%@ include file = "dbconn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>컬럼의 특정 레코드를 읽는 페이지</title>
</head>
<body>

<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String name = request.getParameter("name");
	
	try {
		sql  = "select * from guestboard where name = ? ";
		pstmt  = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		rs = pstmt.executeQuery();
		
		while ( (rs.next())) { 	// 값이  존재 하는 < !  주의 >
			String em = rs.getString("email");
			String na = rs.getString("name");
			String in= rs.getString("inputdate");
			String sub = rs.getString("subject");
			String cnt = rs.getString("content");
			
	%>
			
			<tr>
				<td> <%= em %> </td>
				<td> <%= na %> </td>
				<td> <%= in %> </td>
				<td> <%= sub %> </td>
				<td> <%= cnt %> </td>
			</tr>			
		
	<% 
		 }
		

		// out.println (em);
		
		// 서블릿으로 출력, 서블릿 : JAVA에서 웹페이지를 출력할 수 있는 Java 페이지
		   out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
		   out.println("<tr>");
		   out.println("<td height='22'>&nbsp;</td></tr>");
		   out.println("<tr align='center'>");
		   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
		   out.println("</tr>");
		   
		   out.println("<tr align='center' bgcolor='#DFEDFF'>");
		   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
		   out.println("<div align='left'><font size='2'>"+ rs.getString("subject") + "</div> </td>");
		   out.println("</tr>");
		   
		   out.println("<tr align='center' bgcolor='#FFFFFF'>");
		   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
		   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
		   out.println("<tr bgcolor='#F4F4F4'>");
		   out.println("<td width='13%' height='7'></td>");
		   out.println("<td width='51%' height='7'>글쓴이 : " + rs.getString("name")+ " 글쓴이 : " + rs.getString("email") +"</td>");
		   out.println("<td width='25%' height='7'></td>");
		   out.println("<td width='11%' height='7'></td>");
		   out.println("</tr>");
		   
		   out.println("<tr bgcolor='#F4F4F4'>");
		   out.println("<td width='13%'></td>");
		   out.println("<td width='51%'>작성일 : " + rs.getString("inputdate") + "</td>");
		   out.println("<td width='25%'></td>");
		   out.println("<td width='11%'></td>");
		   out.println("</tr>");
		   
		   out.println("</table>");
		   out.println("</td>");
		   out.println("</tr>");
		   out.println("<tr align='center'>");
		   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
		   out.println("</tr>");
		   out.println("<tr align='center'>");
		   out.println("<td style='padding:10 0 0 0'>");
		   out.println("<div align='left'><br>");
		   out.println("<font size='3' color='#333333'><PRE>"+rs.getString("content") + "</PRE></div>");
		   out.println("<br>");
		   out.println("</td>");
		   out.println("</tr>");
		   out.println("<tr align='center'>");
		   out.println("<td class='button' height='1'></td>");
		   out.println("</tr>");
		   out.println("<tr align='center'>");
		   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
		   out.println("</tr>");
		   out.println("</table>");
		   
	} catch (Exception ex) {
		out.println(ex.getMessage());
	} 
		   
		   %>


<%  	// Vector : 멀티스레드 환경에서 사용, 모든 메소드가 동기화 처리되어 있음. 
	Vector vname =new Vector();			// DB의 Name 값만 저장하는 벡터
	Vector inputdate=new Vector();
	Vector email=new Vector();
	Vector subject=new Vector();
	
	// 페이징 처리 시작 부분
	
	int where=1;
	
	int totalgroup=0;					// 출력할 페이징의 그룹핑의 최대 갯수, 
	int maxpages=5;					// 최대 페이지 갯수 (화면에 출력될 페이지 갯수)
	int startpage=1;					// 처음 페이지
	int endpage=startpage+maxpages-1; // 마지막 페이지
	int wheregroup=1;					// 현재 위치하는 그룹 
	
		// go : 해당 페이지 번호로 이동
		// dbgb_show.jsp?go=3
		// gogroup : 출력할 페이지의 그룹핑
		// dbgb_show.jsp?gogroup=2 	(maxpager가 5일때 6,7,8,9,10)
		
		// go 변수 (페이지번호)를 넘겨 받아서 wheregroup, startpage, endpage 정보의 값을 알아낸다.
		
	if (request.getParameter("go") != null) {					// go 변수의 값을 가지고 있을때
	 where = Integer.parseInt(request.getParameter("go"));	// 현재 페이지 번호를 담은 변수
	 wheregroup = (where-1)/maxpages + 1;						// 현재 위치한 페이지의 그룹
	 startpage=(wheregroup-1) * maxpages+1;  
	 endpage=startpage+maxpages-1; 
	 
	 	// gogroup 변수를 넘겨받아 startpage, endpage, where (페이지 그룹의 첫번째 페이지)
	 
	} else if (request.getParameter("gogroup") != null) {		// gogroup 변수의 값을 가지고 올때
	 wheregroup = Integer.parseInt(request.getParameter("gogroup"));
	 startpage=(wheregroup-1) * maxpages+1;  
	 where = startpage ; 
	 endpage=startpage+maxpages-1; 
	}
	
	int nextgroup = wheregroup+1;		// 다음 그룹 : 현재 그룹 + 1
	int priorgroup = wheregroup-1;	// 이전 그룹 : 현재 그룹 - 1
	
	int nextpage = where+1;			// 다음페이지 : 현재페이지 + 1
	int priorpage = where-1;			// 이전페이지 : 현재페이지 - 1
	int startrow=0;				// 하나의 page에서 레코드 시작 번호
	int endrow=0;					// 하나의 page에서 레코드 마지막 번호
	int maxrows=5;					// 출력할 레코드 수 
	int totalrows=0;				// 총 레코드 갯수
	int totalpages=0;				// 총 페이지 갯수
	
	// 페이징 처리 마지막 부분 
	
	try {
	pstmt = conn.prepareStatement(sql);
	sql = "select * from guestboard " ;
	// rs = pstmt.executeQuery();

	if (!(rs.next()))  {
	 out.println("게시판에 올린 글이 없습니다");
		} else {
		 do {
		   // Database 값을 가져와서 각각의 vector에 저장
		   
	  vname.addElement(rs.getString("name"));
	  email.addElement(rs.getString("email"));
	  String idate = rs.getString("inputdate");
	  idate = idate.substring(0,8);
	  inputdate.addElement(idate);
	  subject.addElement(rs.getString("subject"));
	  
	  
	  
	 } while(rs.next());
	 
	 totalrows = vname.size(); 				// name vector에 저장된 값의 갯수	, 총 레코드 수 
	 totalpages = (totalrows-1)/maxrows +1;
	 startrow = (where-1) * maxrows; 			// 현재 페이지의 시작 레코드 번호
	 endrow = startrow+maxrows-1  ;			// 현재 페이지의 마지막 레코드 번호
	
 
 	if (endrow >= totalrows) 		
 	 endrow=totalrows-1;

 	totalgroup = (totalpages-1)/maxpages +1; 	// 페이지의 그룹핑
 
 	// out.println ("토탈 페이지 그룹 " + totalgroup  + "<p>");
 
 	if (endpage > totalpages) 
  	endpage=totalpages;

 	}

	// for 블락의 마지막 
	
	out.println("</TABLE>");


	if (wheregroup > 1) { 	// 현재 나의 그룹이 1 이상일때는 
	out.println("[<A href=dbgb_show.jsp?gogroup=1>처음</A>]"); 
	out.println("[<A href=dbgb_show.jsp?gogroup="+priorgroup +">이전</A>]");

	} else { 	// 현재 나의 그룹이 1 이상이 아닐때 
	 
	out.println("[처음]") ;
	out.println("[이전]") ;
	}

	if (vname.size() !=0) { 
	for(int jj=startpage; jj<=endpage; jj++) {
 		if (jj==where) 
 	 	out.println("["+jj+"]") ;
		 else
 		 out.println("[<A href=dbgb_show.jsp?go="+jj+">" + jj + "</A>]") ;
	 } 
	}
	
	if (wheregroup < totalgroup) {
 	out.println("[<A href=dbgb_show.jsp?gogroup="+ nextgroup+ ">다음</A>]");
 	out.println("[<A href=dbgb_show.jsp?gogroup="+ totalgroup + ">마지막</A>]");

	} else {
 	out.println("[다음]");
 	out.println("[마지막]");
	}
	out.println ("전체 글수 :"+totalrows); 

	} catch (java.sql.SQLException e) {
		out.println(e);
	} finally {
		pstmt.close();
		conn.close();
		 rs.close();
	}	
	%>
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>
  
</body>
</html>