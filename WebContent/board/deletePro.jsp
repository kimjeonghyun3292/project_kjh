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
   <h1>WebContent/board/deletePro.jsp</h1>
   
   <%
   
   request.setCharacterEncoding("UTF-8");
   
   String pageNum = request.getParameter("pageNum");
   int bno = Integer.parseInt(request.getParameter("bno"));
   String passwd = request.getParameter("passwd");
   
   BoardDAO bdao = new BoardDAO();
   int check =  bdao.deleteBoard(bno,passwd);
   
   if(check==1){  // 정상처리
		  %>
		  <script type="text/javascript">
		  alert("글 삭제 완료!");
		  location.href="boardList.jsp?pageNum<%=pageNum%>";
		  </script>
		  
		  <%

	  }else if(check==0){
		  %>
		  <script type="text/javascript">
		  alert("글 비밀번호 오류!");
		  history.back();
		  </script>
		  
		  <%
		  
	  }else{  // check == -1
	  %>
		  <script type="text/javascript">
		  alert("글 번호 없음!");
		  history.back();
		  </script>
		  <% 
	  }
	  
   
   
   
   
   %>






















</body>
</html>