<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util" %>
<!DOCTYPE html>
<html lang="en">
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
        <link href="css/font.css" rel="stylesheet" />      
        <style>
        header.loginout {
		  position: relative;
		  background-color: #343a40;
		  background: linear-gradient(to bottom, rgba(60, 60, 66, 0.5) 0%, rgba(60, 60, 66, 0.5) 100%), url("assets/img/loginout-bg.jpg") no-repeat center center;
		  background-size: cover;
		  padding-top: 8rem;
		  padding-bottom: 8rem;
		}
		header.loginout h1 {
		  font-size: 2.25rem;
		}
		@media (min-width: 992px) {
		  header.loginout {
		    height: 25vh;
		    min-height: 10rem;
		    padding-top: 4.5rem;
		    padding-bottom: 0;
		  }
		  header.loginout p {
		    font-size: 1.15rem;
		  }
		  header.loginout h1 {
		    font-size: 3rem;
		  }
		}
		@media (min-width: 1200px) {
		  header.loginout h1 {
		    font-size: 3.5rem;
		  }
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
	String userNickname = null;
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
	}
	
	
	
%>
 <!-- 네비게이션 -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top py-3 mb-5">
         
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
<%
	if(userID != null) { // 만약 로그인이 된 상태라면
%>
	    		<div class="collapse navbar-collapse" id="navbarColor02" style="color:white;">
					<a>&nbsp;&nbsp;안녕하세요.&nbsp;&nbsp;<%= userNickname%>님</a>
				</div>
<%
	} else {
%>
  				<div class="collapse navbar-collapse" id="navbarColor02" style="color:white;">
					<a>&nbsp;&nbsp;로그인을 해주세요.&nbsp;&nbsp;</a>
				</div>
<%
	}
%>
             <form class="form-inline my-2 my-lg-0">
               <input class="form-control mr-sm-2" type="text" placeholder="Search">
               <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
          </form>
           </div>     
      </nav>
      <header class="loginout">
            <div class="container h-100">
                <div class="row h-100 align-items-center justify-content-center text-center">
                    <div class="col-lg-10 align-self-end">
                        <h1 class="text-uppercase text-white font-weight-bold">CANCELLATION</h1>
                       <br/><br/>                              
                        
                    </div>  
                </div>
            </div>
        </header>
        
     
 	  <section class="container mb-5" style="max-width: 530px; font-family:'ELAND_Choice_M' ">
	      <form method="post" action="./userDeleteAccountAction.jsp">
	         <br><br>
	         <center><h2 style="font-family:'font'">탈퇴 하기</h2></center>
	         <center><p style="font-family:'gmarket'">아래의 안내 사항을 확인하고, 비밀번호를 입력한 후 동의하고 탈퇴하기 버튼을 눌러 <img src="assets/img/logo.JPG" style="width:90px">서비스를 탈퇴할 수 있습니다.</p></center><hr>
	         
	         <div class= "form-group">
	         <div class="col-lg-20" id="provision">
		         <util:box>
[서비스 탈퇴 안내 사항]<br>
1. 탈퇴 이후에는 해당 계정으로 다시 가입할 수 없습니다.<br>
2. 탈퇴 신청 후 계정의 모든 정보가 삭제됩니다.<br>
3. 삭제된 정보는 복구할 수 없습니다.<br>
4. 탈퇴 후 작성한 댓글, 질문은 수정/삭제할 수 없습니다.<br>
5. 개인정보 처리방침 제5조(개인정보의 보유 및 이용기간)에 따른 특별한 경우, 한시적으로 개인정보를 보존합니다.
		         </util:box>
         	 </div>
         </div> 
	         <br><strong>비밀번호</strong><br>
	         <div class="form-group">
	            <input type="password" name="userPassword" class="form-control" placeholder="비밀번호를 입력해주세요.">            
	         </div>
	         <br><strong>탈퇴 동의</strong><br>
	         "탈퇴 안내사항을 확인하고 동의합니다."를 입력해주세요.
	         <div class="form-group">
	            <input type="text" name="userAgree" class="form-control" placeholder="탈퇴 안내사항을 확인하고 동의합니다.">            
	         </div>
	         <br><br><br>
	         <div class="col text-center">
	         	<input type="button" onclick="location.href='userPasswordCheck2.jsp'" class="btn btn-dark" style = "width: 100px; font-family: 'SEBANG_Gothic_Bold'" value="취소">
	         	<button type="submit" class="btn btn-primary" style = "width: 100px; font-family: 'SEBANG_Gothic_Bold'">탈퇴하기</button>
	         </div>
	      </form>   
      </section>

        <!-- Footer-->
        <footer class="bg-dark mt-3 p-5 text-center" style="color: #FFFFFF;">
         Copyright &copy; 2021 신은정 All Rights Reserved.
      </footer>
        <!-- Bootstrap core JS-->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>