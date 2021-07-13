<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null; 
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
		// userPasswordCheck.jsp에서 사용자가 입력한 비밀번호
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
	if (result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'userDeleteAccount.jsp';");
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