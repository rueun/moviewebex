<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		/* Make the image fully responsive */
		.carousel-inner img {
		    width: 100%;
		    height: 100%;
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
		System.out.println(userNickname);
	}
	

%>
 <!-- 네비게이션 -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top py-3">
			<a class="navbar-brand" href="index.jsp">MOIVEWORLD</a>
			<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
  			<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
   			<ul class="navbar-nav mr-auto">
      			<li class="nav-item active">
        			<a class="nav-link" href="index.jsp">Home<span class="sr-only">(current)</span></a></li>
		     	<li class="nav-item">
		        	<a class="nav-link js-scroll-trigger" href="#movielist">Moviechart</a>
		        </li>
        <%
			if(userID == null || !userID.equals("admin")) { // 만약 로그인이 안된 상태고 관리자가 아니라면
		%>
		        <li class="nav-item">
		        	<a class="nav-link" href="recommend.jsp">Movietaste</a>
		        </li>
		     	<li class="nav-item">
		        	<a class="nav-link" href="contact.jsp">Contact</a>
		        </li>
       	<%} else{%>
       			<li class="nav-item">
		        	<a class="nav-link" href="QnA.jsp">Contact</a>
		        </li>
       	<%} %>
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
						<%if(!userID.equals("admin")) { %>
							<a class="dropdown-item" href="userPasswordCheck.jsp">My page</a>
						<%} %>
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
        <!-- Header-->
        <header class="masthead">
            <div class="container h-100">
                <div class="row h-100 align-items-center justify-content-center text-center">
                    <div class="col-lg-10 align-self-end">
                        <h1 class="text-uppercase text-white font-weight-bold">WELCOME TO MOVIE WORLD</h1>
                        <hr class="divider my-4" />
                    </div>
                    <div class="col-lg-8 align-self-baseline">
                        <p class="text-white-75 font-weight-light mb-5">You can see information about various kinds of movies. Leave your opinion on the movie for many people to see!</p>                
                    </div>
                </div>
            </div>
        </header>
        
        <!-- 홈 화면 슬라이드 배너-->
        <form method="post" class="container mb-5" style="max-width: 1100px;">
         <br><br>
         <h2 style = "font-family : 'font'">무비차트</h2>
         <p style = "font-family : 'gmarket'">생생함이 담긴 영화소식, 다양한 영화를 만나보세요.</p> 
      	</form>
      	<form method="post" class="container mb-0" style="max-width: 1130px;">
	      	<div class="container mt-3">
		        <div id="myCarousel" class="carousel slide" data-ride="carousel">
		            <!-- Indicators -->
		            <ul class="carousel-indicators">
		                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		                <li data-target="#myCarousel" data-slide-to="1"></li>
		                <li data-target="#myCarousel" data-slide-to="2"></li>
		            </ul>
		            <!-- The slideshow -->
		            <div class="carousel-inner">
		                <div class="carousel-item active">
		                    <img src="assets/img/banner/banner1.JPG" alt="Los Angeles" width="1100" height="500">
		                </div>
		                <div class="carousel-item">
		                    <img src="assets/img/banner/banner2.JPG" alt="Chicago" width="1100" height="500">
		                </div>
		                <div class="carousel-item">
		                    <img src="assets/img/banner/banner3.JPG" alt="New York" width="1100" height="500">
		                </div>
		            </div>
		            <!-- Left and right controls -->
		            <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
		                <span class="carousel-control-prev-icon"></span>
		            </a>
		            <a class="carousel-control-next" href="#myCarousel" data-slide="next"> 
		                <span class="carousel-control-next-icon"></span>
		           </a>
		        </div>
    		</div>
      	</form>
      	
        <!-- Page Content-->
        <section class="page-section" id="movielist">
        <div class="container mt-0"><hr>
            <div class="row">
                <div class="col-md-4 mb-5 mt-0">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/endgametitle.png"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">어벤져스: 엔드게임 <p>Avengers: Endgame , 2019</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2019.04.24</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;액션, SF</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;&nbsp;181분</br>
                           	<hr />
                           	<p style = "font-family : 'gmarket'">인피니티 워 이후 절반만 살아남은 지구 마지막 희망이 된 어벤져스 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스 운명을 바꿀 최후의 전쟁이 펼쳐진다!
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/minarititle.jpg"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">미나리 <p>Minari , 2020</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2021.03.03</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드라마</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;115분</br>
                           	<hr />
                           	<p style = "font-family : 'gmarket'">가족들에게 뭔가 해내는 걸 보여주고 싶은 아빠 '제이콥'은 자신만의 농장을 가꾸기 시작하고 엄마 '모니카'도 다시 일자리를 찾는다. 아직 어린 아이들을 위해 ‘모니카’의 엄마 ‘순자’가 함께 살기로 하고, 의젓한 큰딸 '앤'과 장난꾸러기 막내아들 '데이빗'은 여느 그랜마같지 않은 할머니가 영- 못마땅한데…
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/recalledtitle.jpg"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">내일의 기억 <p>Recalled , 2021</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2021.04.21</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;미스터리, 스릴러</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;99분</br>
                           	<hr />
                           	<p style = "font-family : 'gmarket'"> 사고로 기억을 잃은 채 깨어난 수진 옆엔 자상한 남편 지훈이 그녀를 세심하게 돌봐주고 있다. 집에 돌아온 후, 마주친 이웃들의 위험한 미래가 보이기 시작하자 수진은 혼란에 빠진다. 때마침 발견한 사진에서 사진 속 남편 자리엔 지훈이 아닌 다른 남자가 있다. 설상가상 수진은 알 수 없는 남자가 자신을 위협하는 환영에 시달리는데……
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/nomadlandtitle.jpg"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">노매드랜드 <p>Nomadland , 2020</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2021.04.15</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드라마</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;99분</br>
                           	<hr />
                           	<p style = "font-family : 'gmarket'">사고로 기억을 잃은 채 깨어난 수진 옆엔 자상한 남편 지훈이 그녀를 세심하게 돌봐주고 있다. 집에 돌아온 후, 마주친 이웃들의 위험한 미래가 보이기 시작하자 수진은 혼란에 빠진다. 때마침 발견한 사진에서 사진 속 남편 자리엔 지훈이 아닌 다른 남자가 있다. 설상가상 수진은 알 수 없는 남자가 자신을 위협하는 환영에 시달리는데……
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div><div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/raintitle.jpg"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">비와 당신의 이야기 <p>Waiting For Rain , 2020</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2021.04.28</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드라마, 멜로/로맨스</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;117분</br>
                           	<hr />
                           	 <p style = "font-family : 'gmarket'">“몇 가지 규칙만 지켜줬으면 좋겠어. 질문하지 않기, 만나자고 하기 없기 그리고 찾아오지 않기.” ‘소희'는 아픈 언니를 대신해 답장을 보내고 두 사람은 편지를 이어나간다. 우연히 시작된 편지는 무채색이던 두 사람의 일상을 설렘과 기다림으로 물들이기 시작하고, ‘영호'는 12월 31일 비가 오면 만나자는 가능성이 낮은 제안을 하게 되는데...
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div>
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="embed-responsive embed-responsive-16by9">
                        	<img class="embed-responsive-item" src="assets/img/title/seoboktitle.jpg"></img>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" style= "font-family:'SEBANG_Gothic_Bold'">서복 <p>SEOBOK , 2019</p></h5>
                            <p class="card-text">개봉 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2021.04.15</br>
                                                 장르 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드라마</br>
                           	러닝타임 &nbsp;&nbsp;&nbsp;114분</br>
                           	<hr />
                           	 <p style = "font-family : 'gmarket'">실험실 밖 세상을 처음 만나 모든 것이 신기하기만 한 ‘서복‘과 생애 마지막 임무를 서둘러 마무리 짓고 싶은 ‘기헌’은 가는 곳마다 사사건건 부딪친다. 한편, 인류의 구원이자 재앙이 될 수도 있는 ‘서복’을 차지하기 위해 나선 여러 집단의 추적은 점점 거세지고 이들은 결국 피할 수 없는 선택을 하게 되는데…
                            </p>
                        </div>
                        <div class="card-footer"><a class="btn btn-outline-dark ml-5" href="movieinfo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;More Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                    </div>
                </div>
        	</div>
        </div>
        </section>
        <!-- Footer-->
        <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
			Copyright &copy; 2021 신은정 All Rights Reserved.
		</footer>
        <!-- Bootstrap core JS-->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
