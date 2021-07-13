<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDAO" %>
<%@ page import="qna.Qna" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qna" class="qna.Qna" scope="page" />
<jsp:setProperty name="qna" property="qnaAnswer" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이게이게</title>
</head>
<body>
	<%
	String userID = null;
	String userNickname = null;
	String qnaAnswer = null;
	int qnaID = 0;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
	}
	if(request.getParameter("qnaID")!= null){ // QnAdetail.jsp로부터 전달받은 번호를 넣어준다.
		qnaID = Integer.parseInt(request.getParameter("qnaID"));
	}
	if(request.getParameter("qnaAnswer")!= null){ // QnAdetail.jsp로부터 전달받은 번호를 넣어준다.
		qnaAnswer = request.getParameter("qnaAnswer");
	}

	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
	} else {
		if(qna.getQnaAnswer() == null){ // 답변을 입력하지 않았을 때
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('답변을 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
		} else {
			QnaDAO qnaDAO = new QnaDAO();
			int result = qnaDAO.answer(qnaID, qna.getQnaAnswer());
			if (result == -1) { // 데이터베이스 오류 시
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('답변 등록에 실패했습니다.');");
				script.println("history.back();");
				script.println("</script>");
			} else { // 답변 등록 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('답변이 등록되었습니다.');");
				script.println("location.href = 'QnA.jsp'");
				script.println("</script>");
			}
		}
	}	
%>
</body>
</html>