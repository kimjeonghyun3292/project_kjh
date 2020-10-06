<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>WebContent/board/reWritePro.jsp</h1>
  
  <%
  
  request.setCharacterEncoding("UTF-8");
  
  %>
  
   <jsp:useBean id="bb" class="com.itwillbs.board.BoardBean"/>
   <jsp:setProperty property="*" name="bb"/> 
   
   <%
   System.out.println(bb);  //확인차
   
   bb.setIp(request.getRemoteAddr());
   
   BoardDAO bdao = new BoardDAO();
   bdao.reInsertBoard(bb);
   
   
   response.sendRedirect("boardList.jsp");
   
   %>
  
















</body>
</html>