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
	

	// 회원가입 정보
	String userPassword = null;
	String userNickname = null;
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userNickname") != null) {
		userNickname = request.getParameter("userNickname");
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
	
	
	System.out.println("아이디"+ userID);
	System.out.println("패스워드"+userPassword);
	System.out.println("닉네임" +userNickname);
	

	System.out.println(userLikeaction);
	System.out.println(userLikemelo);
	System.out.println(userLikecomedy);
	System.out.println(userLikeresoning);
	System.out.println(userLikehorror);
	System.out.println(userLikefanstasy);
	
	
	if(userID == null || userPassword == null || userID == "" || userPassword == "" || userNickname == null ||  userNickname == "") {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	UserDAO userDAO = new UserDAO();
	FavoriteDAO favoriteDAO = new FavoriteDAO();
	
	int result = userDAO.modify(userID, userPassword, userNickname);
	int result2 = favoriteDAO.modifyfavorite(userID, userLikeaction, userLikemelo, userLikecomedy, userLikeresoning, userLikehorror, userLikefanstasy);
	if (result == 0) { // 수정실패
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('user 수정실패');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else { // 수정완료 후 마이페이지로 이동
		if (result2 == 1) {
			session.setAttribute("userNickname", userNickname); // 세션에 닉네임 등록
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정이 완료되었습니다..');");
			script.println("location.href = 'userModify.jsp'"); //특정페이지로 이동
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('favoritemovie수정실패');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
		
	}	
	
	
	
	
	
%>