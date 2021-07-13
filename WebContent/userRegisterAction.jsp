<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="favoritemovie.FavoriteDAO"%>
<%@ page import="favoritemovie.FavoriteDTO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	
	
	// 회원가입 정보
	String userPassword = null;
	String userEmail = null;
	String userNickname = null;
	String userGender = null;
	String userPasswordcheck = null;
	
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userPasswordcheck") != null) {
		userPasswordcheck = request.getParameter("userPasswordcheck");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	if(request.getParameter("userNickname") != null) {
		userNickname = request.getParameter("userNickname");
	}
	if(request.getParameter("userGender") != null) {
		userGender = request.getParameter("userGender");
	}
	
	
	
	// 좋아하는 영화 장르
	String userLikeaction = "N";
	String userLikemelo = "N";
	String userLikecomedy = "N";
	String userLikeresoning = "N";
	String userLikehorror = "N";
	String userLikefanstasy = "N";
	if(request.getParameter("userLikeaction") != null) {
		userLikeaction = request.getParameter("userLikeaction");
	}
	if(request.getParameter("userLikemelo") != null) {
		userLikemelo = request.getParameter("userLikemelo");
	}
	if(request.getParameter("userLikecomedy") != null) {
		userLikecomedy = request.getParameter("userLikecomedy");
	}
	if(request.getParameter("userLikeresoning") != null) {
		userLikeresoning = request.getParameter("userLikeresoning");
	}
	if(request.getParameter("userLikehorror") != null) {
		userLikehorror = request.getParameter("userLikehorror");
	}
	if(request.getParameter("userLikefanstasy") != null) {
		userLikefanstasy = request.getParameter("userLikefanstasy");
	}
	
	
	System.out.println(userID);
	System.out.println(userPassword);
	System.out.println(userEmail);
	System.out.println(userNickname);
	System.out.println(userGender);
	
	System.out.println(userLikeaction);
	System.out.println(userLikemelo);
	System.out.println(userLikecomedy);
	System.out.println(userLikeresoning);
	System.out.println(userLikehorror);
	System.out.println(userLikefanstasy);
	
	
	if(userID == null || userPassword == null || userEmail == null || userID == "" || userPassword == "" || userEmail == ""
			|| userNickname == null || userGender == null || userNickname == "" || userGender == "") {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	if(userPassword.equals(userPasswordcheck)){ // 비밀번호 확인, 비밀번호가 같은 경우 회원가입
		UserDAO userDAO = new UserDAO(); // UserDAO 객체 생성
		FavoriteDAO favoriteDAO = new FavoriteDAO(); // FavoriteDAO 객체 생성
		int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false, userNickname, userGender));
		int result2 = favoriteDAO.favoritemovie(userID, userLikeaction, userLikemelo, userLikecomedy, userLikeresoning, userLikehorror, userLikefanstasy);
		if (result == -1) { // 회원가입 실패
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else { 
			if (result2 == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('무비 라이크 DB 오류');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				return;
			} else { //회원가입 후 로그인 시켜줌
			session.setAttribute("userID", userID);
			session.setAttribute("userNickname", userNickname);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'emailSendAction.jsp'"); //특정페이지로 이동
			script.println("</script>");
			script.close();
			return;
			}	
		}
	}else{ // 비밀번호와 비밀번호 확인이 다른 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호와 비밀번호 확인이 다릅니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>