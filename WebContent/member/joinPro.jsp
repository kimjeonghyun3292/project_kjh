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
   <h1>WebContent/member/joinPro.jsp</h1>
   
   <%
   
   request.setCharacterEncoding("UTF-8");
   
   
   %>
   
    
     <jsp:useBean id="mb" class="com.itwillbs.member.MemberBean" />
     <jsp:setProperty property="*" name="mb" />
   
   
   <%
   
   MemberDAO mdao = new MemberDAO();
   
   mdao.insertMember(mb);
   
   
   %>
   
   <script type="text/javascript">
	
	  alert("회원 가입 완료");
	  location.href="loginForm.jsp";
	
	</script>
   
   
   
   
   
   
   
   
   
   
   
   
</body>
</html>