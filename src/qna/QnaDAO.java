package qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class QnaDAO {
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
	
	// QnA 번호 반환 함수
	public int getNext() {
		String SQL = "SELECT qnaID FROM QNA ORDER BY qnaID DESC";
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
	
	public int write(String qnaTitle, String userID, String userNickname, String qnaContent) {
		String SQL = "INSERT INTO QNA VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, qnaTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, userNickname);
			pstmt.setString(5, getDate());
			pstmt.setString(6, qnaContent);
			pstmt.setString(7, null);
			pstmt.setInt(8, 1);
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
	
	// 자신의 문의내역 목록 출력
	public ArrayList<Qna> getList(int pageNumber, String userID) {
		String SQL = "SELECT * FROM QNA WHERE qnaID < ? AND userID = ? ORDER BY qnaID DESC LIMIT 5";
		ArrayList<Qna> list = new ArrayList<Qna>(); // select한 값들을 담을 수 있는 리스트 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery(); // 실제 실행했을때 나오는 결과
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQnaID(rs.getInt(1));
				qna.setQnaTitle(rs.getString(2));
				qna.setUserID(rs.getString(3));
				qna.setUserNickname(rs.getString(4));
				qna.setQnaDate(rs.getString(5));
				qna.setQnaContent(rs.getString(6));
				qna.setQnaAnswer(rs.getString(7));
				qna.setQnaConfirm(rs.getInt(8));
				list.add(qna); // 리스트에 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 5개 뽑아온 데이터 리스트 반환
	}
	
	// 관리자용 모든 문의내역 목록 출력
	public ArrayList<Qna> getListAll(int pageNumber) {
		String SQL = "SELECT * FROM QNA WHERE qnaID < ? ORDER BY qnaID DESC LIMIT 10";
		ArrayList<Qna> list = new ArrayList<Qna>(); // select한 값들을 담을 수 있는 리스트 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제 실행했을때 나오는 결과
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQnaID(rs.getInt(1));
				qna.setQnaTitle(rs.getString(2));
				qna.setUserID(rs.getString(3));
				qna.setUserNickname(rs.getString(4));
				qna.setQnaDate(rs.getString(5));
				qna.setQnaContent(rs.getString(6));
				qna.setQnaAnswer(rs.getString(7));
				qna.setQnaConfirm(rs.getInt(8));
				list.add(qna); // 리스트에 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 10개 뽑아온 데이터 리스트 반환
	}
	
	
	
	// 문의사항 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber) { 
		String SQL = "SELECT * FROM QNA WHERE qnaID < ?";
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
	
	// 특정 문의 번호의 하나의 문의 내용 가져오기
	public Qna getQna(int qnaID) {
		String SQL = "SELECT * FROM QNA WHERE qnaID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qnaID);
			rs = pstmt.executeQuery();
			if(rs.next()) { // qna 인스턴스에 값을 다 넣어서 반환
				Qna qna = new Qna();
				qna.setQnaID(rs.getInt(1));
				qna.setQnaTitle(rs.getString(2));
				qna.setUserID(rs.getString(3));
				qna.setUserNickname(rs.getString(4));
				qna.setQnaDate(rs.getString(5));
				qna.setQnaContent(rs.getString(6));
				qna.setQnaAnswer(rs.getString(7));
				qna.setQnaConfirm(rs.getInt(8));
				return qna;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 오류 시 널값 반환하기
	}
	
	// 문의사항 삭제
	public int delete(int noticeID) {
		String SQL = "DELETE FROM QNA WHERE qnaID = ? ";
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
	
	
	// 답변 등록
	public int answer(int qnaID, String qnaAnswer) {
		String SQL = "UPDATE QNA SET qnaAnswer = ?, qnaConfirm = ? WHERE qnaID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, qnaAnswer);
			pstmt.setInt(2,0);
			pstmt.setInt(3, qnaID);
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
