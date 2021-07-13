<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="qna.QnaDAO" %>
<%@ page import="qna.Qna" %>
<%@ page import="java.util.ArrayList" %>
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
	
	// 문의사항 페이징 처리를 위한 작업
	int pageNumber = 1; // 현재 페이지가 무엇인지 알려줌. 1은 기본 페이지를 의미함
	if(request.getParameter("pageNumber")!= null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	System.out.println(pageNumber);
	
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
                        <h1 class="text-uppercase text-white font-weight-bold">MY PAGE</h1>
                       <br/><br/>                              
                        
                    </div>  
                </div>
            </div>
        </header>
        
     
      <form method="post" class="container mb-5" style="max-width: 1100px;">
      <br><br>
         <h2 style="font-family:'font'">마이페이지</h2>
         <p><strong style="color:orange; font-family:'gmarket'"><%=userNickname%></strong><strong style="font-family:'gmarket'">님, 오늘도 영화처럼 멋진 하루 되세요!</strong></p>
         <hr><br>
         <input type="button" onclick="location.href='userPasswordCheck.jsp'" class="btn btn-default" style = "width: 200px; font-family:'ELAND_Choice_M'" value="개인정보수정">
         <input type="button" onclick="location.href='userQuestion.jsp'" class="btn btn-dark" style = "width: 200px; font-family:'ELAND_Choice_M'" value="나의 문의내역">
         <input type="button" onclick="location.href='userPasswordCheck2.jsp'" class="btn btn-defalut" style = "width: 200px; font-family:'ELAND_Choice_M'" value="회원탈퇴">
         <hr style ="margin:0px">
      </form>

 	  <section class="container mb-5" style="max-width: 1100px;">
	      <form method="post" action="./userCommentAction.jsp">
	         <div class="contaioner" style="margin:10px;">
	         	<div class="row">
					<table class="table" style="text-align:center; border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd; font-family:'ELAND_Choice_M'">
						<thead>
							<tr style= "border-top: 3px solid #747474;">
								<th style="background-color:#eeeeee; text-align: center; width:60px;">NO</th>
								<th style="background-color:#eeeeee; text-align: center; width:380px;">제목</th>
								<th style="background-color:#eeeeee; text-align: center; width:110px;">등록일</th>
								<th style="background-color:#eeeeee; text-align: center; width:110px;">답변상태</th>
							</tr>
						</thead>
						<tbody style="background-color:#FFFFFF;">
							<%
								QnaDAO qnaDAO = new QnaDAO();
								ArrayList<Qna> list = qnaDAO.getList(pageNumber, userID);
								for(int i = 0; i < list.size(); i++) {
							%>
							<tr>
								<td><%= list.get(i).getQnaID() %></td>
								<td style="text-align: left;"><a style="color:black;" href="userQuestiondetail.jsp?qnaID=<%= list.get(i).getQnaID() %>"><%= list.get(i).getQnaTitle() %></a></td>
								<td><%= list.get(i).getQnaDate().substring(0, 11)%></td>
								<td><%if(list.get(i).getQnaConfirm() == 1){%>
									<strong style="color:orange;">진행중</strong>
								<%}else{ %>
									<strong>완료</strong>
								<%} %>
								</td>
							</tr>
							<%
								}
							%>	
						</tbody>
					</table>         
	         	</div>
	         </div>
	         <div class="col text-center">
        	 <%
				if(pageNumber != 1) { // 현재 페이지가 1이 아니라면 '이전' 버튼 보이게 하기
			 %>
				<a href="userQuestion.jsp?pageNumber=<%=pageNumber - 1 %>" style="color:black;">이전</a>
				<strong style="color:orange;"><%=pageNumber %></strong>
				<a href="#" style="color:black;">다음</a>
			 <%
				} if(qnaDAO.nextPage(pageNumber + 1)) { // 다음 페이지(pageNumber + 1)가 존재한다면 '다음' 버튼 보이게 하기						
			 %>
			 	<a href="#" style="color:black;">이전</a>
			 	<strong style="color:orange;"><%=pageNumber %></strong>
				<a href="userQuestion.jsp?pageNumber=<%=pageNumber + 1 %>" style="color:black;">다음</a>
			 <%
				}
			 %>
	         </div>
	      </form>
      </section><br>

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