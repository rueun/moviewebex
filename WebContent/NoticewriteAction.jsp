<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="notice" class="notice.Notice" scope="page" />
<jsp:setProperty name="notice" property="noticeTitle" />
<jsp:setProperty name="notice" property="noticeContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이게이게</title>
</head>
<body>
	<%
	String managerID = null;
	
	if(session.getAttribute("userID") != null) {
		managerID = (String) session.getAttribute("userID");
	}
	if(managerID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
	} else {
		if(notice.getNoticeTitle() == null || notice.getNoticeContent() == null){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
		} else {
			NoticeDAO noticeDAO = new NoticeDAO();
			int result = noticeDAO.write(notice.getNoticeTitle(), managerID, notice.getNoticeContent());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('공지 등록에 실패했습니다.');");
				script.println("history.back();");
				script.println("</script>");
			} else { // 강의평가 등록 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('공지가 등록되었습니다.');");
				script.println("location.href = 'Notice.jsp'");
				script.println("</script>");
			}
		}
	}	
%>
</body>
</html>