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
  <h1>WebContent/board/writePro.jsp</h1>
  
  <%
  
  request.setCharacterEncoding("UTF-8");
  
  
  %>
   
   <jsp:useBean id="bb" class="com.itwillbs.board.BoardBean"/>
 
 <% 
  
 %>
 <jsp:setProperty property="*" name="bb"/>
 
 <% 
 
 System.out.println(bb);
 
//IP 정보를 추가(request)
 bb.setIp(request.getRemoteAddr());
 
 System.out.println(bb); 
 
 
 BoardDAO bdao = new BoardDAO();
  
 bdao.insertBoard(bb);
  
 response.sendRedirect("boardList.jsp");
  
  
 %> 
  
  
  
</body>
</html>