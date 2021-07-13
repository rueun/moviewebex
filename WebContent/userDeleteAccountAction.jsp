<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="favoritemovie.FavoriteDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null; 
	String userAgree = null;
	String Agree = "탈퇴 안내사항을 확인하고 동의합니다.";
	
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
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userAgree") != null) {
		userAgree = request.getParameter("userAgree");
	}
	
	System.out.println(userPassword);
	System.out.println(userAgree);
	
	if(userID == null || userPassword == null || userAgree == null || userPassword == "" || userID == "" || userAgree == "") {
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
	
	if(userPassword.equals(userDAO.getUserPassword(userID))){
		if(userAgree.equals(Agree)){
			int result = userDAO.deleteuser(userID);
			int result2 = favoriteDAO.deleteuser(userID);
			if(result == 1 && result2 == 1) { // 삭제 완료한 경우
				session.invalidate();
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제가 완료되었습니다.');");
				script.println("location.href='deletecomplete.jsp';");
				script.println("</script>");
				script.close();
				return;
			} else { // 데이터베이스 오류 발생 시
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				return;
			}
		}else { // 탈퇴동의 제대로 입력안했을 때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴 동의를 정확히 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}else{ // 비밀번호가 다를 때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	
	
	
	
	
%>