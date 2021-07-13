<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ILikeMovie</title>
        <!-- 아이콘-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
        <!-- Third party plugin CSS-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles2.css" rel="stylesheet" />
        
        <style>
        #footer{
        position:absolute;
    	bottom:0;
	    width:100%;
    	height:90px;   
        }
        </style>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null) { // 로그인이 안된 사용자
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3">
			<a class="navbar-brand" href="index.jsp">MOIVEWORLD</a>
			<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
  				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
   			<ul class="navbar-nav mr-auto">
      			<li class="nav-item active">
        			<a class="nav-link" href="index.jsp">Home<span class="sr-only">(current)</span></a></li>
		     	<li class="nav-item">
		        	<a class="nav-link" href="recommend.jsp">Movietaste</a>
		        </li>
		     	<li class="nav-item">
		        	<a class="nav-link" href="contact.jsp">Contact</a>
		        </li>
		        <li class="nav-item">
                 <a class="nav-link" href="Notice.jsp">Notice</a>
               	</li>
		      	<li class="nav-item dropdown">
		        	<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Account</a>
		        	<div class="dropdown-menu">
<%
	if(userID == null) { // 만약 로그인이 안된 상태라면
%>
						<a class="dropdown-item" href="userLogin.jsp">Login</a>
						<a class="dropdown-item" href="userJoin.jsp">Join</a>
						
<%
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">Logout</a>
						<a class="dropdown-item" href="userPasswordCheck.jsp">My Page</a>
<%
	}
%>	
					</div>
		      	</li>
	    	</ul>
   	 		<form class="form-inline my-2 my-lg-0">
      			<input class="form-control mr-sm-2" type="text" placeholder="Search">
      			<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    		</form>
  		</div>
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-warning mt-4 role="alert">
			이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>
	</section>
	<footer class="bg-dark mt-5 p-5 text-center" id=footer style="color: #FFFFFF;">
			Copyright &copy; 2021 신은정 All Rights Reserved.
	</footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>