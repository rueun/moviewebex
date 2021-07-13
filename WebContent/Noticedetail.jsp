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
	
	String userNickname = null;
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
	}
	
	// 공지사항 번호 가져오기
	int noticeID = 0;
	if(request.getParameter("noticeID")!= null){ // Notice.jsp로부터 전달받은 공지번호를 넣어준다.
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	if(noticeID == 0){ // 공지사항 번호가 0이면 알림창 띄우기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 공지사항입니다.');");
		script.println("location.href = 'Notice.jsp';");
		script.println("</script>");
	}
	
	// 공지사항 번호가 존재한다면 구체적인 정보를 notice인스턴스에 담아준다.
	Notice notice = new NoticeDAO().getNotice(noticeID); 
	
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
      <form method="post" class="container mb-5" style="max-width: 1010px;">
         <br><br><br>
         <h1 style="font-family:'font'">공지사항</h1>
         <strong style="color:orange; font-family:'gmarket'">'MOVIE WORLD'</strong><strong style="font-family:'gmarket'">에서 알려드리는 다양한 소식을 만나보세요.</strong>
       	  <hr>
       	  <%
       	  	if(userID != null && userID.equals(notice.getManagerID())) {
       	  %>
       	  	<a href="Noticeupdate.jsp?noticeID=<%= noticeID %>" class="btn btn-dark" style="font-family: 'SEBANG_Gothic_Bold';">수정</a>
       	  	<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="NoticedeleteAction.jsp?noticeID=<%= noticeID %>" class="btn btn-dark" style="font-family: 'SEBANG_Gothic_Bold';">삭제</a>
       	  <%
       	  	}
       	  %>
       	  	<div class="contaioner" style="margin:10px;">
	         	<div class="row">
					<table class="table" style="text-align:left; padding-left:20px; border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd; font-family:'ELAND_Choice_M'">
						<thead>
							<tr style= "border-top: 3px solid #747474;">
								<th style="background-color:#eeeeee; width:120px; padding-left:20px;">작성자</th>
								<th style="background-color:#ffffff; width:230px; padding-left:20px;"><%= notice.getManagerID() %></th>
								<th style="background-color:#eeeeee; width:120px; padding-left:20px;">작성일</th>
								<th style="background-color:#ffffff; width:230px; padding-left:20px;"><%= notice.getNoticeDate().substring(0, 11) %></th>
							</tr>
							<tr>
								<th style="background-color:#eeeeee; width:120px; padding-left:20px;">제목</th>
								<th colspan="3" style="background-color:#ffffff; width:230px; padding-left:20px;"><%= notice.getNoticeTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></th>
							</tr>
						</thead>
						<tfoot>
					        <tr>
					          <td colspan="4" style="height:150px; padding-left:20px;"><%= notice.getNoticeContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					        </tr>
					    </tfoot>
					</table>         
	         	</div>
	         </div>
	         <div class="col text-center">
       	  		<input type="button" onclick="location.href='Notice.jsp'" class="btn btn-primary" style = "width: 60px; font-family: 'SEBANG_Gothic_Bold';" value="목록">
       	  	</div>
       	  <br>
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