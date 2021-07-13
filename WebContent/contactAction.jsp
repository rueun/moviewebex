<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qna" class="qna.Qna" scope="page" />
<jsp:setProperty name="qna" property="qnaTitle" />
<jsp:setProperty name="qna" property="qnaContent" />
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
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(session.getAttribute("userNickname") != null) {
		userNickname = (String) session.getAttribute("userNickname");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
	} else {
		if(qna.getQnaTitle() == null || qna.getQnaContent() == null){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
		} else {
			QnaDAO qnaDAO = new QnaDAO();
			int result = qnaDAO.write(qna.getQnaTitle(), userID, userNickname, qna.getQnaContent());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('문의 등록에 실패했습니다.');");
				script.println("history.back();");
				script.println("</script>");
			} else { // 문의사항 등록 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('문의가 등록되었습니다.');");
				script.println("location.href = 'contactcomplete.jsp'");
				script.println("</script>");
			}
		}
	}	
%>
</body>
</html>