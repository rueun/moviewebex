<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="qna.QnaDAO" %>
<%@ page import="qna.Qna" %>
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
		  background: linear-gradient(to bottom, rgba(60, 60, 66, 0.5) 0%, rgba(60, 60, 66, 0.5) 100%), url("assets/img/contact-bg.jpg") no-repeat center center;
		  background-size: cover;
		  padding-top: 8rem;
		  padding-bottom: 8rem;
		}
		header.loginout h1 {
		  font-size: 2.25rem;
		}
		@media (min-width: 992px) {
		  header.loginout {
		    height: 30vh;
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
	
	
	// 문의사항 번호 가져오기
	int qnaID = 0;
	if(request.getParameter("qnaID")!= null){ // userQuestion.jsp로부터 전달받은 번호를 넣어준다.
		qnaID = Integer.parseInt(request.getParameter("qnaID"));
	}
	if(qnaID == 0){ // 문의 사항 번호가 0이면 알림창 띄우기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 문의사항입니다.');");
		script.println("location.href = 'userQuestion.jsp';");
		script.println("</script>");
	}
	
	// 문의사항 번호가 존재한다면 구체적인 정보를 qna인스턴스에 담아준다.
	Qna qna = new QnaDAO().getQna(qnaID); 
	
	
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
                        <h1 class="text-uppercase text-white font-weight-bold">CONTACT US!</h1>
                       <br><br>                       
                        
                    </div>  
                </div>
            </div>
        </header>
      <form method="post" class="container mb-5" style="max-width: 1100px; margin-top:100px;">
         <h1 style="font-family:'font'">고객센터</h1>
       	  <p><strong style="font-family:'gmarket'">사용문의나 불편하신 부분, 궁금한 사항을 남겨주세요.</strong></p>
       	  <hr>
       	  <%
       	  	if(userID != null && userID.equals(qna.getUserID())) {
       	  %>
       	  	<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="userQuestiondeleteAction.jsp?qnaID=<%= qnaID %>" class="btn btn-dark" style="font-family:'SEBANG_Gothic_Bold'">삭제</a>
       	  <%
       	  	}
       	  %>
       	  	<div class="contaioner" style="margin:10px;">
	         	<div class="row">
					<table class="table" style="text-align:left; padding-left:20px; border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd; font-family:'ELAND_Choice_M'">
						<thead>
							<tr style= "border-top: 3px solid #747474;">
								<th style="background-color:#eeeeee; width:120px; padding-left:20px;">제목</th>
								<th style="background-color:#ffffff; width:230px; padding-left:20px;"><%= qna.getQnaTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></th>
								<th style="background-color:#eeeeee; width:120px; padding-left:20px;">작성일</th>
								<th style="background-color:#ffffff; width:230px; padding-left:20px;"><%= qna.getQnaDate().substring(0, 11) %></th>
							</tr>
						</thead>
						<tfoot>
					        <tr>
					          <td colspan="4" style="height:150px; padding-left:20px;"><%= qna.getQnaContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					        </tr>
					    </tfoot>
					</table>         
	         	</div>
	         </div>
	         <%if(qna.getQnaConfirm() == 0){ // 답변이 완료되었을 때 %>
	         <div class="contaioner" style="margin-right:10px; margin-left:10px;">
	         	<div class="row">
					<table class="table" style="text-align:left; padding-left:20px; border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd; font-family: 'ELAND_Choice_M'">
						<thead>
							<tr>
								<th style="background-color:#ffffff; width:120px; padding-left:20px;"><strong style="color:orange"><%= qna.getUserNickname()%></strong>님, 문의 주신 사항에 대해 답변드립니다.</th>
							</tr>
						</thead>
						<tfoot>
					        <tr>
					          <td colspan="1" style="height:150px; padding-left:20px;"><%= qna.getQnaAnswer().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					        </tr>
					    </tfoot>
					</table>         
	         	</div>
	         </div>
       	  	 <%} %>
       	  	 <div class="col text-center">
       	  		<input type="button" onclick="location.href='userQuestion.jsp'" class="btn btn-primary" style = "width: 60px; font-family: 'SEBANG_Gothic_Bold'" value="목록">
       	  	 </div>
      </form>

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