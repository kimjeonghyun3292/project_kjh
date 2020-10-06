<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>WebContent/member/idCheck.jsp</h1>
  
  
  <%
   
   String id = request.getParameter("userid");
   
   %>
   
   <%--전달받은 값 : <%=id %> --%>
   
  <%
   
   MemberDAO mdao = new MemberDAO();
  
  
   int check =  mdao.joinIdCheck(id);  
   
   if(check == 1){
	   out.print("사용가능한 아이디 입니다.");
	   
	   %>
	   <input type="button" value="아이디 사용하기" onclick="result();">
	   <%
   }else if(check == 0){
	   out.print("사용 불가능한 아이디 입니다. (중복)");
   }else{
	   out.print("에러 발생!!! (-1)");
   }
  
  
  %> 
   <br><br><br>
   <fieldset>
      <form action ="idCheck.jsp" method="post" name="wfr">  
      <!-- post를 넣은 이유: 아이디가 사용가능하면 주소줄에 아이디가 나타나고, 아니면 주소줄에서 숨기기 위함 -->
      ID : <input type="text" name="userid" value="<%=id%>">
      <input type="submit" value="중복 확인">
      
      
      </form>
   </fieldset>
   
   
   <script type="text/javascript">
   function result(){
	   // 중복확인창에서 회원가입 페이지로 정보 전달
	   // 새 창에 있는 아이디 정보 -> 회원가입창에 아이디 정보 전달
	   
	 //  alert("새창 : " + document.wfr.userid.value);
	 //  alert("회원가입창 : " + opener.document.fr.id.value);
	   
	 opener.document.fr.id.value = document.wfr.userid.value;
	             //새창                                       //회원가입창
	             
	 // 회원가입창 제어
	// opener.document.fr.id.disabled="disabled";
	opener.document.fr.id.readOnly="true";
	 
	             
	             
	 // 창 닫기
	 window.close();
	   
	   
   }
   
   
   </script>
   
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
</body>
</html>