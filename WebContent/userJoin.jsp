<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
		    height: 40vh;
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
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다!!.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	String userNickname = null;
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
		System.out.println(userNickname);
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
					<a>&nbsp;&nbsp;환영합니다.&nbsp;&nbsp;<%= userNickname%>님</a>
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
                        <h1 class="text-uppercase text-white font-weight-bold">Join US! </h1>
                       <br/><br/><br/><br/>                                 
                        
                    </div>  
                </div>
            </div>
        </header>
        
        <form method="post" class="container mb-5" style="max-width: 1000px;">
      <br><br>
         <h1 style="font-family:'font'"><center>회원가입</center></h1>
         <center><p style="font-family:'gmarket'">회원 정보를 기입해주세요.</p></center>
         <br><hr>
      </form>
      <section class="container mb-5" style="max-width: 500px; font-family: 'ELAND_Choice_M'">
      <form method="post" action="./userRegisterAction.jsp">
         
         <div class= "form-group">
	         <label for="provision"><strong>회원가입 약관</strong></label>
	         <div class="col-lg-20" id="provision">
		         <textarea class="form-control" rows="5" style="resize:none">약관동의
제 2 장 이용계약

제 5 조 (이용신청)
①이용신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의 가입 신청서 작성)를 거쳐 '확인' 버튼을 누르면 이용신청을 할 수 있다.
②이용신청자는 반드시 실명과 실제 정보를 사용해야 하며 1개의 생년월일에 대하여 1건의 이용신청을 할 수 있다.
③실명이나 실제 정보를 입력하지 않은 이용자는 법적인 보호를 받을 수 없으며, 서비스 이용에 제한을 받을 수 있다.

제 6 조 (이용신청의 승낙)
①회사는 제5조에 따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다.
②회사는 아래 사항에 해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다.
  가. 서비스 관련 설비에 여유가 없는 경우
  나. 기술상 지장이 있는 경우
  다. 기타 회사 사정상 필요하다고 인정되는 경우
③회사는 아래 사항에 해당하는 경우에 승낙을 하지 않을 수 있다.
  가. 다른 사람의 명의를 사용하여 신청한 경우
  나. 이용자 정보를 허위로 기재하여 신청한 경우
  다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우
  라. 기타 회사가 정한 이용신청 요건이 미비한 경우
		         </textarea>
		         <div class="radio">
		              <label>
	              		<input type="radio" id="provisionYn" name="provisionYn" value="Y" checked>
	                                	동의합니다.
	                    </label>
		         </div>
	             <div class="radio">
	                 <label>
	                     <input type="radio" id="provisionYn" name="provisionYn" value="N">
	                     			동의하지 않습니다.
	                 </label>
	             </div>
         	 </div>
         </div>
         
         <div class= "form-group">
	         <label for="memberInfo"><strong>개인정보취급방침</strong></label>
	         <div class="col-lg-20" id="memberInfo">
		         <textarea class="form-control" rows="5" style="resize:none">개인정보의 항목 및 수집방법
제 1 장 총칙

제 1 조 (목적)
본 약관은 Movie World가 운영하는 웹 사이트 (http://www.Movieworld.com)의 제반 서비스의 이용조건 및 절차에 관한 사항 및 기타 필요한 사항을 규정함을 목적으로 한다.

제 2 조 (용어의 정의)
본 약관에서 사용하는 용어는 다음과 같이 정의한다.
①회원 : 기본 회원 정보를 입력하였고, 회사와 서비스 이용계약을 체결하여 아이디를 부여받은 개인
②아이디(ID) : 회원식별과 회원의 서비스 이용을 위해 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합
③비밀번호(Password) : 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합
④해지 : 회사 또는 회원에 의한 이용계약의 종료
		         </textarea>
		         <div class="radio">
		              <label>
	              		<input type="radio" id="memberInfoYn" name="memberInfoYn" value="Y" checked>
	                                	동의합니다.
	                  </label>
		         </div>
	             <div class="radio">
	                 <label>
	                     <input type="radio" id="memberInfoYn" name="memberInfoYn" value="N">
	                     			동의하지 않습니다.
	                 </label>
	             </div>
         	 </div>
         </div>
         <hr>

         <div class="form-group">
            <input type="text" name="userID" class="form-control" id="id" placeholder="아이디">            
         </div>
         <div class="form-group">
            <input type="password" name="userPassword" class="form-control" id="password" placeholder="비밀번호">            
         	<p>&nbsp;영문, 소문자, 숫자가 조합된 8자리 이상만 입력가능합니다.</P>  
         </div>
         <div class="form-group" id="divPasswordCheck">
            <input type="password" name="userPasswordcheck" class="form-control" id="passwordCheck" placeholder="비밀번호 확인">            
         </div>
         <div class="form-group" id="divNickname">
            <input type="text" name= "userNickname" class="form-control" id="nickname" placeholder="닉네임" maxlength="15">
         </div>
         <div class="form-group">
            <input type="text" class="form-control" name="userEmail"  id="email" placeholder="이메일">
            &nbsp;가입완료를 위한 이메일 인증이 진행되오니 정확한 이메일 주소를<br>&nbsp;입력해주세요.
         </div>
         <hr>
         <div class= "form-group">
         	<label for="inputGender" ><strong>성별</strong></label>
         	<div class="radio" name= "userGender">
		             <label>
	              		<input type="radio" id="userGender" name="userGender" value="M" checked>
	                                	남
	                 </label>
		         </div>
	             <div class="radio" name= "userGender">
	                 <label>
	                     <input type="radio" id="userGender" name="userGender" value="F">
	                     			여
	                 </label>
	             </div>
         </div>
         <hr>
         <div class= "form-group">
         	<label for="inputLike"><strong>장르선택, 좋아하는 장르를 선택해주세요.</strong></label>
         	<br>
         	<input type="checkbox" name="userLikeaction" value="Y"> 액션 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikemelo" value="Y"> 멜로 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikecomedy" value="Y"> 코미디
			<br>
			<input type="checkbox" name="userLikeresoning" value="Y"> 추리 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;	
			<input type="checkbox" name="userLikehorror" value="Y"> 공포 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikefanstasy" value="Y"> 판타지	 
         </div>
         
         
         
         
         <br><br><br>
         <div class="col text-center">
         	<button type="submit" class="btn btn-primary" style = "width: 250px; font-family:'gmarket'">회원가입</button>
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