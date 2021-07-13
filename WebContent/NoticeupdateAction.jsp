<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.Notice" %>
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
	}
	int noticeID = 0;
	if(request.getParameter("noticeID")!= null){ // Noticedetail.jsp로부터 전달받은 공지번호를 넣어준다.
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	System.out.println(noticeID);
	if(noticeID == 0){ // 공지사항 번호가 0이면 알림창 띄우기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 공지사항입니다.');");
		script.println("location.href = 'Notice.jsp';");
		script.println("</script>");
	}
	
	Notice notice = new NoticeDAO().getNotice(noticeID);
	
	if(!managerID.equals(notice.getManagerID())){ // 공지 작성자와 현재 아이디가 다르다면 알림창 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정 권한이 없습니다.');");
		script.println("location.href = 'Notice.jsp';");
		script.println("</script>");
	} else {
		if(request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null
				|| request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("")){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
		} else {
			NoticeDAO noticeDAO = new NoticeDAO();
			int result = noticeDAO.update(noticeID, request.getParameter("noticeTitle"), request.getParameter("noticeContent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.');");
				script.println("history.back();");
				script.println("</script>");
			} else { // 강의평가 등록 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('공지가 수정되었습니다.');");
				script.println("location.href = 'Notice.jsp'");
				script.println("</script>");
			}
		}
	}
	
	
	
		
%>
</body>
</html>