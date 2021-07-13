<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userNickname = null;
	
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID"); 
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	
	if(userID == null || userPassword == null || userPassword == "" || userID == "") {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	userNickname = userDAO.getUserNickname(userID);
	if (result == 1) { // 로그인 성공 시
		session.setAttribute("userID", userID); // 세션에 아이디 등록
		session.setAttribute("userNickname", userNickname); // 세션에 닉네임 등록
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인에 성공했습니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	} else if (result == 0){ // 비밀번호가 틀렸을 때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;	
	} else if (result == -1){ // 아이디가 존재하지 않는 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;	
	} else if (result == -2){ // 데이터베이스 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;	
	}
	
%>