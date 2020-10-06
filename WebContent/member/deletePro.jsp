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
   <h1>WebContent/member/deletePro.jsp</h1>
   
   <%
   
   String id = (String)session.getAttribute("id");
   
  
   
   
   request.setCharacterEncoding("UTF-8");
   
   String pass = request.getParameter("pass");
   
   MemberDAO mdao = new MemberDAO();
   
   
   int result = mdao.deleteMember(id, pass);
   
   
   if(result==1){
		  session.invalidate();  // 초기화 후 자바스크립트로 이동
		  %>
		  <script type="text/javascript">
		  alert("탈퇴완료!");
		  location.href="../main/main.jsp";
		  </script>
		  <%
		 
	  }else if(result==0){
		  %>
		  <script type="text/javascript">
		  alert("비밀번호 오류!");
		  history.back();
		  </script>
		  <%
	  }else{ //result == -1
		  %>
		  <script type="text/javascript">
		  alert("아이디 없음 오류");
		  history.back();
		  </script>
		  <% 
	  }
	  
	  
   
   
   
   %>
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
</body>
</html>