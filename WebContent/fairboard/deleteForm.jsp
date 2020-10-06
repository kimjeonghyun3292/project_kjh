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
        <a href="../fileboard/boardList.jsp">
          <i class="zmdi zmdi-link"></i> 포럼/엑스포
        </a>
      </li>
      <li>
        <a href="boardList.jsp">
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

	<title>Delete</title>
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

<!-- 글 삭제 -->

<title>deleteForm</title>
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


%>

<div class="container">
  <h2>게시글 삭제</h2>
  <p></p>       
  <form action="deletePro.jsp?pageNum<%=pageNum %>" method="post" name="delete">  
  <div class="form-group">
      <input type="hidden" class="form-control" id="bno" name="bno" value="<%=bno%>">  
      </div>
    <div class="form-group">
      <label for="passwd">비밀번호:</label>
      <input type="password" class="form-control" id="passwd" name="passwd">
    </div>
   <input type="submit" class="btn btn-default" value="삭제">
 </form>
 
  
  
</div>



<br><br><br><br><br>












<!-- 글 삭제 -->

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