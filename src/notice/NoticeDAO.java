package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class NoticeDAO {
	
	public String getDate() { // 현재 시간 가져오기
		String SQL = "SELECT NOW()";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // 실제실행했을때 나오는 결과
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	// 게시물 번호 반환 함수
	public int getNext() {
		String SQL = "SELECT noticeID FROM NOTICE ORDER BY noticeID DESC";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // 실제 실행했을때 나오는 결과
			if (rs.next()) {
				return rs.getInt(1) + 1; // 이전 게시물 번호 받아와서 1을 더해준 수를 반환
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String noticeTitle, String managerID, String noticeContent) {
		String SQL = "INSERT INTO NOTICE VALUES (?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, managerID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
			pstmt.setInt(6, 1);
			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}
	
	
	// 공지글 목록 출력
	public ArrayList<Notice> getList(int pageNumber) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 5";
		ArrayList<Notice> list = new ArrayList<Notice>(); // select한 값들을 담을 수 있는 리스트 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // 실제 실행했을때 나오는 결과
			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setManagerID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				list.add(notice); // 리스트에 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 5개 뽑아온 데이터 리스트 반환
	}
	
	
	// 공지사항 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber) { 
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과가 하나라도 존재한다면
				return true; // 다음 페이지로 넘어갈 수 있음을 알려줌
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 다음 페이지로 넘어갈 수 없음
	}
	
	
	// 특정 공지번호의 하나의 공지 내용 가져오기
	public Notice getNotice(int noticeID) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			rs = pstmt.executeQuery();
			if(rs.next()) { // notice 인스턴스에 값을 다 넣어서 반환
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setManagerID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				return notice;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 오류 시 널값 반환하기
	}
	
	
	// 공지사항 업데이트 구문
	public int update(int noticeID, String noticeTitle, String noticeContent) {
		String SQL = "UPDATE NOTICE SET noticeTitle = ?, noticeContent = ? WHERE noticeID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContent);
			pstmt.setInt(3, noticeID);
			return pstmt.executeUpdate(); // 성공시 0 이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}
	
	
	// 공지사항 삭제
	public int delete(int noticeID) {
		String SQL = "UPDATE NOTICE SET noticeAvailable = 0 WHERE noticeID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			return pstmt.executeUpdate(); // 성공시 0 이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}
	
}
