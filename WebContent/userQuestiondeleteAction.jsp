<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDAO" %>
<%@ page import="qna.Qna" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이게이게</title>
</head>
<body>
	<%
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
	}
	int qnaID = 0;
	if(request.getParameter("qnaID")!= null){ // userQuestiondetail.jsp로부터 전달받은 공지번호를 넣어준다.
		qnaID = Integer.parseInt(request.getParameter("qnaID"));
	}
	System.out.println(qnaID);
	if(qnaID == 0){ // 문의 사항 번호가 0이면 알림창 띄우기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 문의 사항입니다.');");
		script.println("location.href = 'userQuestion.jsp';");
		script.println("</script>");
	}
	
	Qna qna = new QnaDAO().getQna(qnaID);
	
	if(!userID.equals(qna.getUserID())){ // 문의사항 작성자와 현재 아이디가 다르다면 알림창 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제 권한이 없습니다.');");
		script.println("location.href = 'userQuestion.jsp';");
		script.println("</script>");
	} else {
		QnaDAO qnaDAO = new QnaDAO();
		int result = qnaDAO.delete(qnaID);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('문의사항 삭제에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
		} else { // 문의사항 삭제 완료
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('문의사항이 삭제되었습니다.');");
			script.println("location.href = 'userQuestion.jsp'");
			script.println("</script>");
		}	
	}
		
		
%>
</body>
</html>