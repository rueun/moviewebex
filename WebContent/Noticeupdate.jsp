<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notice.Notice" %>
<%@ page import="notice.NoticeDAO" %>
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
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String userNickname = null;
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
	}
	
	int noticeID = 0;
	if(request.getParameter("noticeID")!= null){ // Noticedetail.jsp로부터 전달받은 공지번호를 넣어준다.
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	System.out.println("업데이트" + noticeID);
	if(noticeID == 0){ // 공지사항 번호가 0이면 알림창 띄우기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 공지사항입니다.');");
		script.println("location.href = 'Notice.jsp';");
		script.println("</script>");
	}
	
	Notice notice = new NoticeDAO().getNotice(noticeID);
	
	if(!userID.equals(notice.getManagerID())){ // 공지 작성자와 현재 아이디가 다르다면 알림창 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정 권한이 없습니다.');");
		script.println("location.href = 'Notice.jsp';");
		script.println("</script>");
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
						<a class="dropdown-item" href="userPasswordCheck.jsp">My page</a>
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
					<%if(userID.equals("admin")) { %>
						<a>&nbsp;&nbsp;안녕하세요.&nbsp;&nbsp;관리자님</a>
					<%}else{ %>
						<a>&nbsp;&nbsp;안녕하세요.&nbsp;&nbsp;<%= userNickname%>님</a>
					<%} %>
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
                        <h1 class="text-uppercase text-white font-weight-bold">NOTICE</h1>
                       <br/><br/>                              
                    </div>  
                </div>
            </div>
        </header>
      <form method="post" class="container" style="max-width: 1010px;">
      <br><br><br>
         <h1 style="font-family:'font'">공지사항 수정</h1>
         <strong style="color:orange; font-family: 'gmarket'">'MOVIE WORLD'</strong><strong style="font-family:'gmarket'"> 공지사항을 수정해주세요.</strong>
         <hr>
      </form>
      <section class="container mb-5" style="max-width: 1000px;">
	      <form method="post" action="NoticeupdateAction.jsp?noticeID=<%= noticeID%>">
	         <div class="contaioner" style="margin:10px;" >
	         	<div class="row">
					<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd; font-family: 'ELAND_Choice_M'">
						<thead>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="noticeTitle" maxlength="50" value ="<%= notice.getNoticeTitle() %>"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="noticeContent" maxlength="2048" style="height:350px;"><%= notice.getNoticeContent() %></textarea></td>
							</tr>
						</tbody>
					</table>
	         	</div>
	         </div>
	         <div class="col text-center">
	         	<a href="Noticedetail.jsp?noticeID=<%= noticeID%>" class="btn btn-dark" style="font-family:'SEBANG_Gothic_Bold'">취소</a>
				<input type="submit" class="btn btn-primary" value="수정하기" style="font-family:'SEBANG_Gothic_Bold'">
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