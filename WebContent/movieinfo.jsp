<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@page import= "java.io.*"%>


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
        <link href="css/styles3.css" rel="stylesheet" />
        
        <style>
        .review_ly .ly_inner .input_choice .choice_box {
		    overflow: hidden;
		    display: inline-block;
		    position: relative;
		    left: -8px;
		    vertical-align: top;
		    margin-top: 20px;
		}
        </style>
    </head>
    <body>
<%
	request.setCharacterEncoding("UTF-8");
	String movieName = "어벤져스: 엔드게임";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	String userID = null;
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));		
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");	
		}
	}
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) { // 이메일 확인이 안됨
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
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
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top py-3">
			<a class="navbar-brand" href="index.jsp">MOIVEWORLD</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
  				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor02">
   				<ul class="navbar-nav mr-auto">
      				<li class="nav-item active">
        				<a class="nav-link" href="index.jsp">Home<span class="sr-only">(current)</span></a>
        			</li>
        			<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#movieinfo">Movieinfo</a></li>
		      		<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#photo">Photo</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#rating">Rating</a></li>
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
        <!-- Header-->
        <header class="masthead">
            <div class="container h-100">
                <div class="row h-100 align-items-center justify-content-center text-center">
                    <div class="col-lg-10 align-self-end">
                    	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                        <h2 class="text-uppercase text-white font-weight-bold">어벤져스: 엔드게임</h2>                
                        <p class="text-uppercase text-white font-weight-bold">Avengers: Endgame, 2019</p>
                        <hr class="divider my-4" />
                    </div>  
                </div>
            </div>
        </header>
        <!-- MovieInfo -->
        <section class="page-section" id="Movieinfo">  
        <div class="container">
            <div class="row">
                <div class="col-md-10 mb-0 mt-4">
                	<h2>Movie Info</h2>
                    <hr />
                	<div class="row align-items-center my-3">
	                	<div class="col-lg-4"><img class="img-fluid rounded mb-4 mb-lg-0" src="assets/img/poster/advengersposter.jpg" alt="..."></div>
	                	<div class="col-lg-8">
	                    <div class="mov_info">
							<h3 class="tit">어벤져스: 엔드게임</h3>
							<p class="tit_eng"><span>Avengers: Endgame</span></p>
							<p class="sub_info"><span>2019</span><span>&emsp;|&emsp;미국</span><span class="grade002">&emsp;|&emsp;12세이상관람가</span></p>
							<p class="sub_info"><span>장르 : 액션, SF</span><span>&emsp;|&emsp;상영시간 : 181분</span></p>
							<p class="sub_info"><span>개봉일 : 2019-04-24</span><span>&emsp;|&emsp;누적관객 : 13,822,297명</span></p>
							<p class="sub_info">감독 : <a href="https://movie.naver.com/movie/bi/pi/filmo.nhn?code=6942&v=i">안소니 루소</a><a href="https://movie.naver.com/movie/bi/pi/basic.nhn?code=6943">   조 루소</a></p>
							<p class="sub_info">출연 : <a href="https://movie.naver.com/movie/bi/pi/filmo.nhn?code=1326&v=i">로버트 다우니 주니어</a>(토니 스타크/아이언맨)<a href="https://movie.naver.com/movie/bi/pi/basic.nhn?code=5514"> 크리스 에반스</a>(스티브 로저스/캡틴 아메리카)</p></div>
	                	</div>          
           			</div> 
                </div>
                <div class="col-md-10 mb-5">
                	<hr />
                    <h4>Plot</h4>
                    <div class="story">								
<%
            BufferedReader reader = null;
            try {
                String filePath = application.getRealPath("/WEB-INF/avengers.txt");
                reader = new BufferedReader(new FileReader(filePath));
                while (true) {
                    String str = reader.readLine();
                    if (str == null)
                        break;
                    out.println(str + "<BR>");
                }
            }
            catch (FileNotFoundException fnfe) {
                out.println("파일이 존재하지 않습니다.");
            }
            catch (IOException ioe) {
                out.println("파일을 읽을 수 없습니다.");
            }
            finally {
                try {
                    reader.close();
                }
                catch (Exception e) {
                }
            }
%>
					</div>
                </div>
            </div>
        </div>
        </section>
        <!-- photo -->
        <section class="page-section" id="photo">
        <div class="container">
            <div class="row">
                <div class="col-md-10 mb-5 mt-0">
                    <h2>Photo</h2>
                    <hr />
                    <div id="portfolio">
            			<div class="container-fluid p-0">
                			<div class="row no-gutters">
                   				<div class="col-lg-4 col-sm-6">
                        			<a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers1.jpg">
                            		<img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers1.jpg" alt="...">
                            			<div class="portfolio-box-caption">
                                		<div class="project-category text-white-50">크게보기</div>
                           				 </div>
                        			</a>
                    			</div>
                    			
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers2.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers2.jpg" alt="...">
			                            <div class="portfolio-box-caption">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers3.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers3.jpg" alt="...">
			                            <div class="portfolio-box-caption">
											<div class="project-category text-white-50">크게보기</div>
										</div>
			                 	       </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers4.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers4.jpg" alt="...">
			                            <div class="portfolio-box-caption">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers5.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers5.jpg" alt="...">
			                            <div class="portfolio-box-caption">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers6.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers6.jpg" alt="...">
			                            <div class="portfolio-box-caption p-3">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers7.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers7.jpg" alt="...">
			                            <div class="portfolio-box-caption p-3">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>      
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers8.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers8.jpg" alt="..." width="400" height="300">
			                            <div class="portfolio-box-caption p-3">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                    
			                    <div class="col-lg-4 col-sm-6">
			                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/avengers9.jpg">
			                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/avengers9.jpg" alt="...">
			                            <div class="portfolio-box-caption p-3">
			                                <div class="project-category text-white-50">크게보기</div>
			                            </div>
			                        </a>
			                    </div>
			                          
			                </div>
			            </div>            
			        </div>
              	</div>  
           	 </div>
         	</div>
      </section>
            <section class="page-section" id="rating">  
	       	<div class="container">
	            <div class="row">
	                <div class="col-md-10 mb-5 mt-5">
	                    <h2>Rating</h2>
	                    <hr />
	                    <form method="get" action="./movieinfo.jsp" class="form-inline mt-3">
							<select name="searchType" class="form-control mx-1 mt-2">
								<option value="최신순">최신순</option>
								<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>			
							</select>
							<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
							<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
							<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
							<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>		
						</form>
<% 
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(movieName, searchType, search, pageNumber);
	if(evaluationList != null) // 사용자가 가져온 반환된 리스트가 널값이 아니라면
		for(int i = 0; i < evaluationList.size(); i++) {
			if(i == 5) break;
			EvaluationDTO evaluation = evaluationList.get(i);
%>						
							<div class="card bg-light mt-3">
								<div class="card-header bg-light">
									<div class="row">
										<div class="col-8 text-left"><%= evaluation.getEvaluationTitle()%></div>
										<div class="col-4 text-right">
											평점: <span style="color: red;"><%= evaluation.getRatingScore() %></span>
										</div>					
									</div>				
								</div>
							<div class="card-body">
								<p class="card-text"><%= evaluation.getEvaluationContent() %>
								<br/> <small><%= evaluation.getUserID() %> | <%= evaluation.getEvaluationDate() %></small>
								</p>
								
								<div class="row">
									<div class="col-9 text-left">
										연출: <span style="color: red;"><%= evaluation.getDirectionScore() %></span>
										연기: <span style="color: red;"><%= evaluation.getActingScore() %></span>
										스토리: <span style="color: red;"><%= evaluation.getStoryScore() %></span>
										영상미: <span style="color: red;"><%= evaluation.getVisualScore() %></span>		
									</div>
									<div class="col-3 text-right">
										<span style="color: green;">(추천: <%= evaluation.getLikeCount() %>)</span>
										<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
										<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
									</div>
								</div>		
							</div>		
						</div>
<%
	}
%>	
        		</div>
        	</div>
        	</div>
        	
        	</section>
        	
   
   <!-- 등록하기 모달 -->
   <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog" style="width:400px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">내 평점 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-group">
							<h5 class="text-center">어벤져스: 엔드게임</h5>
							<hr class="divider my-4">
							<p class="text-center">평점을 선택하세요</p>
							<div class="form-row">
							<div class="form-group col-sm-4">
							</div>
							<div class="form-group col-sm-4">
								<select name="ratingScore" class="form-control" style="width:100px;">
									<option value="1점" selected>1점</option>
									<option value="2점">2점</option>
									<option value="3점">3점</option>
									<option value="4점">4점</option>
									<option value="5점">5점</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
							</div>
						</div>		
						</div>
						<hr/>
						<div class="form-group">
							<input type="text" name="evaluationTitle" placeholder="글제목을 입력해주세요" class="form-control" maxlength="30">					
						</div>
						<div class="form-group">
							<textarea name="evaluationContent" class="form-control" placeholder="감상평을 남겨주세요. 영화와 상관없는 내용은 재재를 받을 수 있습니다." maxlength="2048" style="height: 120px;"></textarea>	
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>연출</label>
								<select name="directionScore" class="form-control">
									<option value="1점" selected>1점</option>
									<option value="2점">2점</option>
									<option value="3점">3점</option>
									<option value="4점">4점</option>
									<option value="5점">5점</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>연기</label>
								<select name="actingScore" class="form-control">
									<option value="1점" selected>1점</option>
									<option value="2점">2점</option>
									<option value="3점">3점</option>
									<option value="4점">4점</option>
									<option value="5점">5점</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>스토리</label>
								<select name="storyScore" class="form-control">
									<option value="1점" selected>1점</option>
									<option value="2점">2점</option>
									<option value="3점">3점</option>
									<option value="4점">4점</option>
									<option value="5점">5점</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>영상미</label>
								<select name="visualScore" class="form-control">
									<option value="1점" selected>1점</option>
									<option value="2점">2점</option>
									<option value="3점">3점</option>
									<option value="4점">4점</option>
									<option value="5점">5점</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>						
						</div>																
					</form>
				</div>
			</div>
		</div>
	</div>
   
   <!-- 신고하기 모달 -->
   <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">					
						</div>
						<div class="form-group">
							<label>신고내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>	
						</div>						
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>						
						</div>																
					</form>
				</div>
			</div>
		</div>
	</div>	
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
