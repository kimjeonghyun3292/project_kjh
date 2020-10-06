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

	<title>Update Info</title>
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
 <h1>WebContent/member/updateForm.jsp</h1>

    <%
   String id = (String)session.getAttribute("id");
   if(id==null){
	   response.sendRedirect("loginForm.jsp");
   }
   
   
   MemberDAO mdao = new MemberDAO();
 
   MemberBean mb = mdao.getMember(id);
   
  %>



	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form-title" style="background-image: url(images/bg-01.jpg);">
					<span class="login100-form-title-1">
						정보 수정
					</span>
				</div>
				<form action="updatePro.jsp" method="post" class="login100-form validate-form" name="fr">
					<div class="wrap-input100 validate-input m-b-26" data-validate="아이디 필수 입력">
						<span class="label-input100">아이디</span>
						<input class="input100" type="text" name="id" value="<%=mb.getId()%>" readonly>
						<span class="focus-input100"></span>
					</div>
					
					

					<div class="wrap-input100 validate-input m-b-18" data-validate = "비밀번호 필수 입력">
						<span class="label-input100">비밀번호</span>
						<input class="input100" type="password" name="pass" placeholder="비밀번호를 입력하세요">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "비밀번호 확인 필수 입력">
						<span class="label-input100">비밀번호 확인</span>
						<input class="input100" type="password" name="pass2" placeholder="비밀번호를 입력하세요">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "이름 필수 입력">
						<span class="label-input100">이름</span>
						<input class="input100" type="text" name="name" value="<%=mb.getName()%>">
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "생년월일 필수 입력">
						<span class="label-input100">생년월일</span>
						<input class="input100" type="text" name="birthday" value="<%=mb.getBirthday()%>">
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
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "연락처 필수 입력">
						<span class="label-input100">연락처</span>
						<input class="input100" type="text" name="phone" value="<%=mb.getPhone()%>">
						<span class="focus-input100"></span>
					</div>
					
					<SCRIPT src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></SCRIPT>
					<div class="wrap-input100 validate-input m-b-18" data-validate = "주소 필수 입력">
						<span class="label-input100">주소</span>
						<button type="button" class="btn btn-danger dup" style="height:45px !important; " onclick="execDaumPostcode();">우편번호 검색</button>
						<input class="input100" type="text" id="zip" name="zip" placeholder="우편번호 검색을 통해 입력" value="<%=mb.getZip()%>">
						<input class="input100" type="text" id="addr1" name="addr1" placeholder="우편번호 검색을 통해 입력" value="<%=mb.getAddr1()%>">
						<input class="input100" type="text" id="addr2" name="addr2" placeholder="상세주소 입력 입력" value="<%=mb.getAddr2()%>">
						<span class="focus-input100"></span>
						</div>
					
					<script>
					
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullRoadAddr;
                document.getElementById('addr2').focus();
                }
                }).open();
                 }  
                </script>
					
					
					
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "이메일 필수 입력">
						<span class="label-input100">이메일</span>
						<input class="input100" type="text" name="email" value="<%=mb.getEmail()%>">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-18" data-validate = "참여행사 필수 입력">
						<span class="label-input100">참여예정 행사</span>
						<input class="input100" type="text" name="event" value="<%=mb.getEvent()%>">
						<span class="focus-input100"></span>
					</div>
					
				
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							  정보수정
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