<%@page import="com.itwillbs.community.CommunityDAO"%>
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
  
   <jsp:useBean id="cb" class="com.itwillbs.community.CommunityBean"/>
   <jsp:setProperty property="*" name="cb"/> 
   
   <%
   System.out.println(cb);  //확인차
   
   cb.setIp(request.getRemoteAddr());
   
   CommunityDAO cdao = new CommunityDAO();
   cdao.reInsertBoard(cb);
   
   
   response.sendRedirect("boardList.jsp");
   
   %>
  
















</body>
</html>