
<%@page import="com.itwillbs.file.FileBoardBean"%>
<%@page import="com.itwillbs.file.FileBoardDAO"%>
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
        <a href="boardList.jsp">
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


	<title>Content</title>
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

<!-- 글 내용보기 -->

<title>content</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<%

 int bno = Integer.parseInt(request.getParameter("bno"));
String pageNum = request.getParameter("pageNum");

FileBoardDAO fdao = new FileBoardDAO();

//글의 조회수 정보를 1증가 => updateReadCount(bno) 
fdao.updateReadCount(bno);

FileBoardBean fb = fdao.getBoard(bno);


%>


<div class="container">
  <h2>포럼/엑스포</h2>
  <p></p>            
  <table class="table table-hover">
    <thead>
      <tr>
        <th colspan="5"><%=fb.getSubject() %></th>
        <th></th>
       

      </tr>
    </thead>
    <tbody>
      <tr>
        <td><%=fb.getBno() %></td>
        <td><%=fb.getName() %></td>
        <td></td>
        <td><%=fb.getDate() %></td>
        <td colspan="3"><%=fb.getReadcount() %></td>
      </tr>
      <tr>
        <td colspan="5"><img src = "../upload/<%=fb.getFile() %>" style="width:500px; height:500px;">
        <p style="white-space:pre;"><%=fb.getContent() %></p> <p></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
      <td>Download</td>
        <th colspan="3"><a href="file_down.jsp?file_name=<%=fb.getFile() %>"><%=fb.getFile() %></a></th>
        <td></td>
        <td></td>
      </tr>
      
    </tbody>
  </table>
  
  <%
  String id = (String)session.getAttribute("id"); 
  
  if(id!=null && id.equals(fb.getName())){
  
  %>
  
  <input type="button" class="btn btn-default" onclick="location.href='updateForm.jsp?bno=<%=fb.getBno() %>&pageNum=<%=pageNum %>'" value="수정">
  
  <input type="button" class="btn btn-default" onclick="location.href='deleteForm.jsp?bno=<%=fb.getBno()%>&pageNum=<%=pageNum%>'" value="삭제">
  <%
      }else if(id==null || !id.equals(fb.getName())){  //로그인 정보가 없거나(아이디가 null) 또는 아이디와 이름이 같지 않은 경우
        	      
          }
              
              %>
              
   
   
  <input type="button" class="btn btn-default" onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>'" value="목록">


  
  
</div>



<br><br>


<!-- 글 내용보기 -->







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