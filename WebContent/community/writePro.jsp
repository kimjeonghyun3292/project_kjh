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
  <h1>WebContent/board/writePro.jsp</h1>
  
  <%
  
  request.setCharacterEncoding("UTF-8");
  
  
  %>
   
   <jsp:useBean id="cb" class="com.itwillbs.community.CommunityBean"/>
 
 <% 
  
 %>
 <jsp:setProperty property="*" name="cb"/>
 
 <% 
 
 System.out.println(cb);
 
//IP 정보를 추가(request)
 cb.setIp(request.getRemoteAddr());
 
 System.out.println(cb); 
 
 
 CommunityDAO cdao = new CommunityDAO();
  
 cdao.insertBoard(cb);
  
 response.sendRedirect("boardList.jsp");
  
  
 %> 
  
  
  
</body>
</html>