 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
      // 화면 상단에 위치하는 메뉴처리(모든 페이지에 공유)
    
      // 로그인 체크(세션 id 값이 있는지 없는지 체크)
      String id = (String)session.getAttribute("id");
    %>

     <header>
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="../main/main.jsp">행사 한 눈에 보기</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="../main/main.jsp">홈 <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../board/boardList.jsp">공지사항</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../fileboard/boardList.jsp">포럼/엑스포</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../fairboard/boardList.jsp">박람회/페어</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../community/boardList.jsp">커뮤니티</a>
        </li>
      </ul>
     
     <div id="login">
      <%
      if( id == null ){
       %>
       <ul class="navbar-nav mr-auto">
       <li class="nav-item">
          <a class="nav-link" href="../member/loginForm.jsp">로그인</a>
          </li>
          <li class="nav-item">
          <a class="nav-link" href="../member/joinForm.jsp">회원가입</a>
        </li>
        </ul>
        <%
        }else{
		%>
		<ul class="navbar-nav mr-auto">
		 <li class="nav-item">
		 <a class="nav-link"><%=id %>님 환영합니다</a> 
		 </li>
		 <li class="nav-item">
		 <a class="nav-link" href="../member/myPage.jsp">마이페이지</a>|
		 </li>
		 <li class="nav-item">
		 <a class="nav-link" href="../member/updateForm.jsp">정보수정</a>
		 </li>
		 <li class="nav-item">
		 <a class="nav-link" href="../member/logout.jsp">로그아웃</a></div>
		 </li>
		 </ul>
		 	<%
	     }
       %>
    </div>
  </nav>
</header>