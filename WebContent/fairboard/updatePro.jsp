<%@page import="com.itwillbs.fair.FairBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h1>WebContent/fileboard/updatePro.jsp</h1>

  <%
  
  request.setCharacterEncoding("UTF-8");
  
  String pageNum = request.getParameter("pageNum");
  
  
  %>
  
  <jsp:useBean id="ab" class="com.itwillbs.fair.FairBoardBean"/>
  <jsp:setProperty property="*" name="ab"/>
  
  <%
  
  FairBoardDAO adao = new FairBoardDAO();
  
  int check = adao.updateBoard(ab);
  
  if(check == 1){
  	%>
  	<script type="text/javascript">
  	alert("글 수정 완료");
  	location.href="boardList.jsp?pageNum=<%=pageNum%>";
  	</script>
  	<% 
  	
  }else if(check==0){
  	%>
  	<script type="text/javascript">
  	alert("비밀번호 오류");
  	history.back();
  	</script>
  	<% 
  }else{  //check == -1
  %>
  	<script type="text/javascript">
  	alert("존재하지 않는 글번호 입니다");
  	history.back();
    </script>
  <%
  }
  
  
  
  %>























</body>
</html>