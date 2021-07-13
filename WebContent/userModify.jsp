<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO"%>
<%@ page import="favoritemovie.FavoriteDAO"%>
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
		    height: 50vh;
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
	String userGender = null;
	String userEmail = null;
	
	// 영화 선호도 조사
	String userLikeaction = null;
	String userLikemelo = null;
	String userLikecomedy = null;
	String userLikeresoning = null;
	String userLikehorror = null;
	String userLikefanstasy = null;
	
	
	
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
	
	// 회원정보 가져오기
	UserDAO userDAO = new UserDAO();
	userGender = userDAO.getUserGender(userID);
	userEmail = userDAO.getUserEmail(userID);
	
	FavoriteDAO favoriteDAO = new FavoriteDAO();
	userLikeaction = favoriteDAO.getUserLikeaction(userID);
	userLikemelo = favoriteDAO.getUserLikemelo(userID);
	userLikecomedy = favoriteDAO.getUserLikecomedy(userID);
	userLikeresoning = favoriteDAO.getUserLikereasoning(userID);
	userLikehorror = favoriteDAO.getUserLikehorror(userID);
	userLikefanstasy = favoriteDAO.getUserLikefantasy(userID);
	
	System.out.println(userLikeaction);
	System.out.println(userLikemelo);
	System.out.println(userLikecomedy);
	System.out.println(userLikeresoning);
	System.out.println(userLikehorror);
	System.out.println(userLikefanstasy);
	
	
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
						<a class="dropdown-item" href="userPasswordCheck.jsp">Memberinfo</a>
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
                        <h1 class="text-uppercase text-white font-weight-bold">Member INfo</h1>
                       <br/><br/><br/><br/><br/>                                   
                        
                    </div>  
                </div>
            </div>
      </header>
      
      <form method="post" class="container mb-5" style="max-width: 1000px;">
      <br><br>
         <center><h1 style="font-family:'font'">회원정보수정</h1></center>
         <center><p style="font-family:'gmarket'">필요한 정보를 수정해주세요.</p></center>
         <br><hr>
      </form>
      <section class="container mb-5" style="max-width: 500px; font-family:'ELAND_Choice_M'">
      <form method="post" action="./userModifyAction.jsp">
         <div class="form-group">
         <label><strong>아이디</strong></label>
            <input type="text" name="userID" class="form-control" id="id" placeholder=<%=userID%> value=<%=userID%> readonly> 
         </div>
         <div class="form-group">
            <input type="password" name="userPassword" class="form-control" id="password" placeholder="비밀번호">
            <p>&nbsp;영문, 소문자, 숫자가 조합된 8자리 이상만 입력가능합니다.</P>  
         </div>
         <div class="form-group" id="divPasswordCheck">
            <input type="password" name="userPasswordcheck" class="form-control" id="passwordCheck" placeholder="비밀번호 확인">            
         </div>
         <div class="form-group" id="divNickname">
         	<label><strong>닉네임</strong></label>
            <input type="text" name= "userNickname" class="form-control" id="nickname" placeholder=<%=userNickname%> value=<%=userNickname%> maxlength="15">
         </div>
         <div class="form-group">
         	<label><strong>이메일</strong></label>
            <input type="text" class="form-control" name="userEmail"  id="email" placeholder=<%=userEmail%> readonly>
            <label><P>&nbsp;정확한 이메일 주소를 입력해주세요.</P></label>            
         </div>
         <hr>
         <div class= "form-group">
         	<label for="inputGender" ><strong>성별</strong></label>
         	<div class="radio" name= "userGender">
		             <label <%if(userGender.equals("M")){%>style="font-weight:bold; color:skyblue;"<%}%>>
	              		<input type="radio" id="userGender" name="userGender" value="M" 
	              		<%if(userGender.equals("M")){%>checked<%}%> disabled>
	                                	남
	                 </label>
		         </div>
	             <div class="radio" name= "userGender">
	                 <label <%if(userGender.equals("F")){%> style="font-weight:bold; color:orange;"<%}%>>
	                     <input type="radio" id="userGender" name="userGender" value="F" 
	                     <%if(userGender.equals("F")){%>checked <%}%> disabled>
	                     			여
	                 </label>
	             </div>
         </div>
         <hr>
         <div class= "form-group">
         	<label for="inputLike"><strong>장르선택, 좋아하는 장르를 선택해주세요.</strong></label>
         	<br>
         	<input type="checkbox" name="userLikeaction" value="Y" <%if(userLikeaction.equals("Y")){%>checked<%}%>>  액션 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikemelo" value="Y" <%if(userLikemelo.equals("Y")){%>checked<%}%>>  멜로 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikecomedy" value="Y" <%if(userLikecomedy.equals("Y")){%>checked<%}%>>  코미디
			<br><br>
			<input type="checkbox" name="userLikeresoning" value="Y" <%if(userLikeresoning.equals("Y")){%>checked<%}%>>  추리 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikehorror" value="Y" <%if(userLikehorror.equals("Y")){%>checked<%}%>>  공포 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="checkbox" name="userLikefanstasy" value="Y" <%if(userLikefanstasy.equals("Y")){%>checked<%}%>>  판타지	 
         </div>
         

         <br><br><br>
         <div class="col text-center">
         	<button type="submit" class="btn btn-primary" style = "width: 100px; font-family:'SEBANG_Gothic_Bold'">수정</button>
         	<input type="button" onclick="location.href='userPasswordCheck.jsp'" class="btn btn-dark" style = "width: 100px; font-family:'SEBANG_Gothic_Bold'" value="취소">
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