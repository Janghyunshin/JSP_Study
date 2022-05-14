<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*, java.util.*, java.text.*" %>    
<% request.setCharacterEncoding("EUC-KR"); %>    <!-- �ѱ� ó�� -->
<%@ include file = "dbconn_oracle.jsp" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� �޾Ƽ� DataBase�� ���� �־��ִ� ����</title>
</head>
<body>
<%	// ������ �ѱ� ���� ����
	String na = request.getParameter("name");				// �̸�
	String em = request.getParameter("email");				// �̸���
	String sub = request.getParameter("subject");			// ����
	String cont = request.getParameter("content");			// ����
	
	int id = 1;		// DB�� id�÷��� ������ ��.
	
	int pos = 0;
	if (cont.length() ==1) {
		cont = cont + " " ;
	}
	
	while ((pos = cont.indexOf("\'", pos)) != -1) { 	// -1 ���� �������� ������
		String left = cont.substring (0,pos);
			//out.println ("pos : " + pos + "<p>");
			//out.println ("left : " + left + "<p>");
			
		String right = cont.substring (pos, cont.length());
			//out.println ("right : " +right + "<p>");
			
		cont = left + "\'" + right;
		pos += 2;
	}
	
	// ������ ��¥ ó��
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyy.MM.dd a h:mm");
	String ymd = myformat.format(yymmdd);
	
	// ��������
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0; 			// Insert �� �� �Ǿ����� �׷��� ������ Ȯ���ϴ� ���� 
	
	try {
			// ���� �����ϱ� ���� �ֽ� �۹�ȣ�� (max(id))�� ���� �ͼ�  + 1 �� �����Ѵ�.
			// conn (Connection) : Auto commit; �� �۵� �ȴ�.
				//commit�� ���� ���� �ʾƵ� insert, update, delete, �ڵ� Ŀ���� �ȴ�.
				
			st = conn.createStatement();
			sql = "select * from guestboard";
			rs = st.executeQuery(sql);

		sql = "insert into guestboard (name, email, inputdate, subject, content)";
		sql = sql + "values ('" +na+ "','" +em+ "', '" +ymd+ "','" +sub+ "','" +cont+ "')";
		
		cnt = st.executeUpdate(sql);	// cnt > 0 : Insert ����
		out.println(sql);
		
		if (cnt > 0 ) {
			out.println("�����Ͱ� ���������� �Է� �Ǿ����ϴ�.");
		} else {
			out.println("�����Ͱ� �Էµ��� �ʾҽ��ϴ�.");
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

<!-- ������ �̵� 
	
	jsp:forward 			: �����ܿ��� �������� �̵�, Ŭ���̾�Ʈ�� ������ URL ������ �ٲ��� �ʴ´�.
	response.sendRedirect	: 
		Ŭ���̾�Ʈ���� �������� ���û���� ������ �̵�, �̵��ϴ� �������� URL ������ �ٲ��.

 -->
 
</body>
</html>