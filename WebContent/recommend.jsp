<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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

	//영화 선호도 조사
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
	
	
	
	FavoriteDAO favoriteDAO = new FavoriteDAO();
	userLikeaction = favoriteDAO.getUserLikeaction(userID);
	userLikemelo = favoriteDAO.getUserLikemelo(userID);
	userLikecomedy = favoriteDAO.getUserLikecomedy(userID);
	userLikeresoning = favoriteDAO.getUserLikereasoning(userID);
	userLikehorror = favoriteDAO.getUserLikehorror(userID);
	userLikefanstasy = favoriteDAO.getUserLikefantasy(userID);
	
	
	
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
                        <h1 class="text-uppercase text-white font-weight-bold">RECOMMED MOVIE</h1>
                       <br/><br/>                              
                        
                    </div>  
                </div>
            </div>
        </header>
        
     
      <form method="post" class="container mb-5" style="max-width: 1000px;">
      <br><br>
         <h1 style="font-family: 'font';">영화 추천</h1>
         <p><strong style="color:orange; font-family: 'gmarket';"><%=userNickname%></strong><strong style="font-family: 'gmarket';">님의 취향을 저격할만한 영화입니다!</strong></p>
         <hr><br>
         
         <%if(userLikeaction.equals("Y")){ // 액션영화를 선호 한다면 %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">액션</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/action1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70" >
	                    		 어벤져스: 엔드게임<br>
	                    		(Avengers: Endgame)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.04.24<br>
	                        	장르| 액션, SF<br>
	                        	국가| 미국<br>
	                        	러닝타임| 181분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; font-family: 'gmarket'; text-decoration: underline;">12<br></strong><strong style ="font-family: 'gmarket'"> 어벤져스: 엔드게임</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/action2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		반도<br>
	                    		(영화Peninsula)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2020.07.15<br>
	                        	장르| 액션, 드라마<br>
	                        	국가| 한국<br>
	                        	러닝타임| 116분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 반도</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>		
		<%if(userLikemelo.equals("Y")){ %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">멜로/로맨스</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/melo1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 러브 앳<br>
	                    		(Love at Second Sight)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.11.27<br>
	                        	장르| 멜로/로맨스, 코미디<br>
	                        	국가| 프랑스, 벨기에<br>
	                        	러닝타임| 118분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 러브 앳</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/melo2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 미 비포  유<br>
	                    		(Me Before You)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2016.06.01<br>
	                        	장르| 멜로/로맨스<br>
	                        	국가| 미국<br>
	                        	러닝타임| 110분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 미 비포 유</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/melo3.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 노트북<br>
	                    		(The Notebook)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2004.11.26<br>
	                        	장르| 멜로/로맨스, 드라마<br>
	                        	국가| 미국<br>
	                        	러닝타임| 123분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 노트북</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>		
		<%if(userLikecomedy.equals("Y")){ %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">코미디</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/comedy1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 엑시트<br>
	                    		(EXIT)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.07.31<br>
	                        	장르| 액션, 코미디<br>
	                        	국가| 한국<br>
	                        	러닝타임| 103분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 엑시트</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/comedy2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 극한직업<br>
	                    		(Extreme Job)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.01.23<br>
	                        	장르| 코미디<br>
	                        	국가| 한국<br>
	                        	러닝타임| 111분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 극한직업</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/comedy3.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 탐정: 리턴즈<br>
	                    		(The Accidental Detective 2: In Action)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2018.06.13<br>
	                        	장르| 코미디, 범죄<br>
	                        	국가| 한국<br>
	                        	러닝타임| 116분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 탐정: 리턴즈</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>
		<%if(userLikeresoning.equals("Y")){ %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">추리/미스터리</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/reasoning1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 나비브스 아웃<br>
	                    		(Knives Out)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.12.04<br>
	                        	장르| 추리, 미스터리, 스릴러<br>
	                        	국가| 미국<br>
	                        	러닝타임| 130분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 나비브스 아웃</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/reasoning2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 셜록: 유령신부<br>
	                    		(SHERLOCK)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2016.01.02<br>
	                        	장르| 범죄, 드라마<br>
	                        	국가| 영국, 미국<br>
	                        	러닝타임| 115분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 셜록: 유령신부</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>
		<%if(userLikefanstasy.equals("Y")){ %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">판타지</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/fantasy1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 비밀의 숲 테라비시아<br>
	                    		(Bridge To Terabithia)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2019.07.31<br>
	                        	장르| 판타지, 가족, 모험<br>
	                        	국가| 미국<br>
	                        	러닝타임| 94분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:green; text-decoration: underline; font-family: 'gmarket';">전체<br></strong><strong style ="font-family: 'gmarket'"> 비밀의 숲 테라비시아</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/fantasy2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 해리포터와 불사조 기사단<br>
	                    		(Harry Potter And The Order Of The Phoenix)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2007.07.11<br>
	                        	장르| 판타지, 가족, 모험, 액션<br>
	                        	국가| 미국, 영국<br>
	                        	러닝타임| 137분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:green; text-decoration: underline; font-family: 'gmarket';" >전체<br></strong><strong style ="font-family: 'gmarket'"> 해리포터와 불사조 기사단</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/fantasy4.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		신비한 동물사전<br>
	                    		(Fantastic Beasts and Where to Find Them)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2016.11.16<br>
	                        	장르| 판타지, 모험<br>
	                        	국가| 영국, 미국<br>
	                        	러닝타임| 132분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:skyblue; text-decoration: underline; font-family: 'gmarket';">12<br></strong><strong style ="font-family: 'gmarket'"> 신비한 동물사전</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/fantasy3.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		벽 속에 숨은 마법시계<br>
	                    		(The House With a Clock In Its Walls)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2018.10.31<br>
	                        	장르| 판타지, 미스터리, 스릴러<br>
	                        	국가| 미국<br>
	                        	러닝타임| 105분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:green; text-decoration: underline; font-family: 'gmarket';">전체<br></strong><strong style ="font-family: 'gmarket'"> 벽 속에 숨은 마법시계</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>

		<%if(userLikehorror.equals("Y")){ %>
         <div id="portfolio">
         <h5><strong style= "font-family: 'SEBANG_Gothic_Bold';">공포/호러</strong></h5>
    		<div class="container-fluid p-0">
        		<div class="row">
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/horror1.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 컨저링 2<br>
	                    		(The Conjuring 2)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2016.06.09<br>
	                        	장르| 공포<br>
	                        	국가| 미국<br>
	                        	러닝타임| 134분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 컨저링2</strong>
            		</div>
            		<div class="col-lg-3 col-sm-6">
                		<a class="portfolio-box" href="movieinfo.jsp">
	                    	<img class="img-fluid" src="assets/img/recommend/horror2.jpg" alt="...">
	                    	<div class="portfolio-box-caption">
	                    		<div class="project-category text-white-70">
	                    		 곤지암<br>
	                    		(GONJIAM: Haunted Asylum)
	                    		</div><br>
	                        	<div class="project-category text-white-50" style="text-align:left;">
	                        	개봉| 2018.03.28<br>
	                        	장르| 공포, 미스터리<br>
	                        	국가| 한국<br>
	                        	러닝타임| 94분
	                        	</div>
	                   		</div>
                		</a>
                		<strong style="color:pink; text-decoration: underline; font-family: 'gmarket';">15<br></strong><strong style ="font-family: 'gmarket'"> 곤지암</strong>
            		</div>
               </div>
           </div>
           <br><br>
		</div>
<%} %>

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