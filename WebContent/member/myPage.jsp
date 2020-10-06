<%@page import="com.itwillbs.member.MemberBean"%>
<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 헤더파일들어가는 곳 (페이지 인클루드) -->
 <jsp:include page="../inc/top.jsp"></jsp:include>

<!-- 헤더파일들어가는 곳 -->   

	<title>Mypage</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
 <h1>WebContent/member/myPage.jsp</h1>

   <%
    
	String id = (String) session.getAttribute("id");

	if (id == null) {
		response.sendRedirect("loginForm.jsp");
	}

	
	// 회원의 정보를 DB에서 가져와서 페이지에 출력
	
	MemberDAO mdao = new MemberDAO();

	
	MemberBean mb = mdao.getMember(id);
  
	if(mb != null){
	
  %>



	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form-title" style="background-image: url(images/bg-01.jpg);">
					<span class="login100-form-title-1">
						마이페이지
					</span>
				</div>
				<form action="updatePro.jsp" method="post" class="login100-form validate-form" name="fr" id="update">
					<div class="wrap-input100 validate-input m-b-26">
						<span class="label-input100">아이디</span>
						<input class="input100" type="text" name="id" value="<%=mb.getId()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					

					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">비밀번호</span>
						<input class="input100" type="password" name="pass" value="<%=mb.getPass()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
	
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">이름</span>
						<input class="input100" type="text" name="name" value="<%=mb.getName()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">생년월일</span>
						<input class="input100" type="text" name="birthday" value="<%=mb.getBirthday()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">성별</span>
						<input class="input110" type="radio" name="gender" value="남"
						<%if(mb.getGender().equals("남")){ %>
                         checked
                          <%} %>
						>남
						<input class="input110" type="radio" name="gender" value="여"
						<%if(mb.getGender().equals("여")){ %>
                          checked
                           <%} %>
						>여<br><br>
						<span class="label-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">연락처</span>
						<input class="input100" type="text" name="phone" value="<%=mb.getPhone()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					<SCRIPT src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></SCRIPT>
					<div class="wrap-input100 validate-input m-b-18" data-validate = "주소 필수 입력">
						<span class="label-input100">주소</span>
						<input class="input100" type="text" id="zip" name="zip" placeholder="우편번호 검색을 통해 입력" value="<%=mb.getZip()%>" readonly>
						<input class="input100" type="text" id="addr1" name="addr1" placeholder="우편번호 검색을 통해 입력" value="<%=mb.getAddr1()%>" readonly>
						<input class="input100" type="text" id="addr2" name="addr2" placeholder="상세주소 입력 입력" value="<%=mb.getAddr2()%>" readonly>
						<span class="focus-input100"></span>
						</div>
					
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">이메일</span>
						<input class="input100" type="text" name="email" value="<%=mb.getEmail()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18">
						<span class="label-input100">참여예정 행사</span>
						<input class="input100" type="text" name="event" value="<%=mb.getEvent()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
				    <div class="container-login100-form-btn inline">
						<button class="login100-form-btn">
						<%} %>
							  <a href="../main/main.jsp">메인으로</a>
						</button>
					</div>
					<div class="container-login110-form-btn inline">
						<button class="login110-form-btn">
							  <a href="deleteForm.jsp">회원 탈퇴</a>
						</button>
					</div>
					
				
					

					
			
			</div>
		</div>
	
  
 
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
<!-- 푸터 들어가는 곳 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</body>
</html>