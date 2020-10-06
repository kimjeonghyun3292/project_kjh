<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>WebContent/member/updatePro.jsp</h1>
  
  
  <%

   String id = (String)session.getAttribute("id");
  
  if(id==null){
	  response.sendRedirect("../main/main.jsp");
  }
  
   request.setCharacterEncoding("UTF-8");
   
 
   
   %>
   <jsp:useBean id="mb" class="com.itwillbs.member.MemberBean" />
   <jsp:setProperty property="*" name="mb"/>     
   
   
   <% 
  
  
   MemberDAO mdao = new MemberDAO();
  
  
   int result = mdao.updateMember(mb);
  
   if(result==1){
	   %>
	   <script type="text/javascript">
	   alert("수정 완료");
	   location.href="../main/main.jsp";
	   </script>
	   <%
	   
   }else if(result==0){
	   %>
	   <script type="text/javascript">
	   alert("비밀번호 오류");
	   history.back();
	   </script>
	   <%
	   
   }else{  // -1
	   %>
	   <script type="text/javascript">
	   alert("아이디 정보 없음");
	   history.back();
	   </script>
	   <%
	   
   }
  
  
  %>
  
  
  
  
  
  
  
  
  
  
</body>
</html>