<%@page import="com.itwillbs.file.FileBoardBean"%>
<%@page import="com.itwillbs.file.FileBoardDAO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="submenuCss.css">
<head>
<!-- 헤더파일들어가는 곳 (페이지 인클루드) -->
 <jsp:include page="../inc/top.jsp"></jsp:include>

<!-- 헤더파일들어가는 곳 -->   

<!-- 서브메뉴 들어가는 곳 -->

<div id="viewport">
  <!-- Sidebar -->
  <div id="sidebar">
    <header>
      <a href="#">         </a>
    </header>
    <ul class="nav">
      <li>
        <a href="../board/boardList.jsp">
          <i class="zmdi zmdi-view-dashboard"></i> 공지사항
        </a>
      </li>
      <li>
        <a href="#">
          <i class="zmdi zmdi-link"></i> 포럼/엑스포
        </a>
      </li>
      <li>
        <a href="../fairboard/boardList.jsp">
          <i class="zmdi zmdi-widgets"></i> 박람회/페어
        </a>
      </li>
      
      <li>
        <a href="../community/boardList.jsp">
          <i class="zmdi zmdi-comment-more"></i> 커뮤니티
        </a>
      </li>
    </ul>
  </div>
  <!-- Content -->
  <div id="content">
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <ul class="nav navbar-nav navbar-right">
          <li>
            <a href="#"><i class="zmdi zmdi-notifications text-danger"></i>
            </a>
          </li>
        </ul>
      </div>
    </nav>
    <div class="container-fluid">
     
    </div>
  </div>
</div>

<!-- 서브메뉴 들어가는 곳 -->




	<title>Forum/Expo</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="backgroundCss/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="backgroundCss/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="backgroundCss/css/util.css">
	<link rel="stylesheet" type="text/css" href="backgroundCss/css/main.css">
<!--===============================================================================================-->
</head>
</body>

<!-- 게시판 -->

<head>
  <title>FileBoardList</title> 
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="boardList.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<%

FileBoardDAO fdao = new FileBoardDAO();

int cnt = fdao.getBoardCount();

System.out.println("테이블에 저장된 글의 수 : " + cnt);

//*** 페이징 처리 ***

// 한 페이지 당 글 개수
int pageSize = 8;

//현 페이지의 페이지 값
String pageNum = request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";
}

// 시작 행번호(1, 11, 21, 31 ..)
 int currentPage = Integer.parseInt(pageNum);
// 행번호 계산
 int startRow = (currentPage-1) * pageSize + 1;
// 끝 행번호 계산 (10, 20, 30, 40..)
 int endRow = currentPage * pageSize;




 ArrayList boardList = null; 

 if(cnt != 0){
	// boardList = fdao.getBoardList();
	 // 페이징 처리한 리스트 호출 (시작행, 페이지 크기)
	 boardList = fdao.getBoardList(startRow, pageSize);
 }

%>



<div class="container">
 <h2>포럼/엑스포</h2>
  <p>게시판 글의 수 : <%=cnt %></p>
  <br>
  
  
  
    <table class="table table-striped">
    <thead>
      <tr>
        
      <%
      
      for(int i=0;i<boardList.size();i++){ 
	  FileBoardBean fb = (FileBoardBean)boardList.get(i);
  
      %>
      </thead>
      
    <tbody>
    <div class="box" style="width:1000px;">
	    <div class="thumbnail" style="width:215px; float:left; margin-left:30px">
	   <a href="content.jsp?bno=<%=fb.getBno() %>&pageNum=<%=pageNum %>"><img src = "../upload/<%=fb.getFile() %>" 
	     style="width:215px; height:215px;"></a>
	    <a href="content.jsp?bno=<%=fb.getBno() %>&pageNum=<%=pageNum %>" style="font-size:14px"><%=fb.getSubject() %></a>
   </div>

    </div>
  
       
     <%--   <td><%=fb.getSubject() %></td>--%> 
  <%--       <% 
        // 답글 들여쓰기
        int wid = 0; 
        
        if(fb.getRe_lev()>0){
        	wid = 10 * fb.getRe_lev();
        %>
        <img src="level.gif" width="<%=wid%>" height="15">
          <img src="this.jpg" width="10px" height="10px"> 
        <% 
         }
          %>  --%>
      <%--   <a href="content.jsp?bno=<%=fb.getBno()%>&pageNum=<%=pageNum%>"><%=fb.getSubject() %></a>--%>
        
      
      
      
      <%
    }
    %>
   
    </tbody>
  </table>
  
   <a class="btn btn-default pull-right" href="writeForm.jsp">글쓰기</a>
  
 
 
  
   
  
</div>

<%
// 다른 페이지 이동 버튼
  if(cnt != 0){
	
	 int pageCount = cnt/pageSize + (cnt % pageSize == 0? 0:1) ;	
	
	 // 한 화면에 보여줄 페이지 개수
	 int pageBlock = 3;
	
	 //페이지 블럭 시작 페이지 번호(1~10/11~20/21~30/31~40)
	 int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	
	// 페이지 블럭의 끝 페이지 번호
	 int endPage = startPage+pageBlock-1;
	  if(endPage > pageCount) {
	 endPage = pageCount;
	// 페이지가 카운트보다 크게 나올경우 endPage를 pagecount로 바꿈(전체페이지 수를 넘어설 수 없어서)
}

  %>



 
 <div class="text-center">
  <ul class="pagination">
  <% 
  if(startPage > pageBlock){
  %>
    <li><a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">이전</a></li>
   <!--  <li><a href="#">1</a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>   -->
    <% 
     }
    
    for(int i=startPage;i<=endPage;i++){
    	  %>
		   <li><a href="boardList.jsp?pageNum=<%=i%>"><%=i %></a></li>
		 <%
    
    
    }
  if(endPage < pageCount) {
    %>
    <li><a href="boardList.jsp?pageNum=<%=startPage + pageBlock%>">다음</a></li>
    <%
  }
    
  }
      
  
    %>
  </ul>
 
 </div>
</body>
</html>
<!-- 게시판 -->


<!--===============================================================================================-->
	<script src="backgroundCss/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/vendor/bootstrap/js/popper.js"></script>
	<script src="backgroundCss/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/vendor/daterangepicker/moment.min.js"></script>
	<script src="backgroundCss/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="backgroundCss/js/main.js"></script>
	
<!-- 푸터 들어가는 곳 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->

</body>
</html>