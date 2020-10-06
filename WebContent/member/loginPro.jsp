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
  <h1>WebContent/member/loginPro.jsp</h1>
  
  <%
  request.setCharacterEncoding("UTF-8");
  
  
  String id = request.getParameter("id");
  String pass = request.getParameter("pass");
  
  MemberDAO mdao = new MemberDAO();
  
  int result = mdao.idCheck(id,pass);
  
  if(result == 1){
	  // 로그인 성공
	  
	  // 아이디 값을 세션 객체에 저장
	 session.setAttribute("id", id);    // id자리가 object인데 String을 넣었기 때문에 upcasting됨
	  response.sendRedirect("../main/main.jsp");
	  
  }else if(result == 0){
	  %>
	  <script type="text/javascript">
	  alert("비밀번호 오류!");
	  history.back();
	  </script>
	  
	   <% 
  }else{  //result == -1
	  %>
  <script type="text/javascript">
  alert("존재하지 않는 아이디");
  history.back();
  
  </script>
	  <% 
  }
  
  
  %>
  
  
  
  
  
  






</body>
</html>