<%-- 강의평가를 등록할 수 있는 액션 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	String movieName = "어벤져스: 엔드게임";
	String ratingScore = null; 
	String evaluationTitle = null; 
	String evaluationContent = null; 
	String directionScore = null; 
	String actingScore = null; 
	String storyScore = null;
	String visualScore = null;
	String evaluationDate = null;

	
	
	if(request.getParameter("ratingScore") != null) {
		ratingScore = request.getParameter("ratingScore");
	}
	if(request.getParameter("evaluationTitle") != null) {
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null) {
		evaluationContent = request.getParameter("evaluationContent");
	}
	if(request.getParameter("directionScore") != null) {
		directionScore = request.getParameter("directionScore");
	}
	if(request.getParameter("actingScore") != null) {
		actingScore = request.getParameter("actingScore");
	}
	if(request.getParameter("storyScore") != null) {
		storyScore = request.getParameter("storyScore");
	}
	if(request.getParameter("visualScore") != null) {
		visualScore = request.getParameter("visualScore");
	}
	if(request.getParameter("evaluationDate") != null) {
		evaluationDate = request.getParameter("evaluationDate");
	}
	
	System.out.println(movieName);
	System.out.println(ratingScore);
	System.out.println(evaluationTitle);
	System.out.println(evaluationContent);
	System.out.println(directionScore);
	System.out.println(actingScore);
	System.out.println(storyScore);
	System.out.println(visualScore);
	System.out.println(evaluationDate);


	
	if(movieName == null || ratingScore == null || evaluationTitle == null || directionScore == null ||
			evaluationTitle == null || evaluationContent == null || directionScore == null ||
			actingScore == null || storyScore == null || visualScore == null ||
			evaluationTitle.equals("") || evaluationContent.equals("")){
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('입력 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, movieName, ratingScore,
			evaluationTitle, evaluationContent, directionScore, actingScore,
			storyScore, visualScore, "", 0));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('영화 평점 등록을 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else { // 강의평가 등록 완료
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'movieinfo.jsp'");
		script.println("</script>");
		script.close();
		return;	
	}
	
%>