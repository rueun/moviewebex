package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import notice.Notice;
import util.DatabaseUtil;

public class EvaluationDAO {
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int write(EvaluationDTO evaluationDTO) {
		String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getMovieName());
			pstmt.setString(3, evaluationDTO.getRatingScore());
			pstmt.setString(4, evaluationDTO.getEvaluationTitle());
			pstmt.setString(5, evaluationDTO.getEvaluationContent());
			pstmt.setString(6, evaluationDTO.getDirectionScore());
			pstmt.setString(7, evaluationDTO.getActingScore());
			pstmt.setString(8, evaluationDTO.getStoryScore());
			pstmt.setString(9, evaluationDTO.getVisualScore());
			pstmt.setString(10, getDate());			
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<EvaluationDTO> getList (String movieName, String searchType, String search, int pageNumber) {
		if(movieName.equals("전체")) {
			movieName = ""; // 전체는 공백으로 처리해 모든게 출력되게 만듦
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM EVALUATION WHERE movieName LIKE ? AND CONCAT(movieName, evaluationTitle, evaluationContent) LIKE " +
						"? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
						
			} else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM EVALUATION WHERE movieName LIKE ? AND CONCAT(movieName, evaluationTitle, evaluationContent) LIKE " +
						"? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + movieName + "%");
			pstmt.setString(2, "%" + search + "%"); // 사용자가 검색한 내용이 포함이 되어있느냐
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11),
					rs.getInt(12)
				);
				evaluationList.add(evaluation); // 모든 강의평가 데이터를 리스트에 담을 수 있게 함
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList; //결과적으로 리스트에 담긴 모든 데이터를 반환한다.
	}
	
	
	
	public int like(String evaluationID) { // 추천수 증가	
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));			
			return pstmt.executeUpdate(); // 실행한 결과를 반환 (좋아요 수)
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(String evaluationID) { // 강의평가 삭제 함수
		String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 데이터베이스 오류
	}
	
	public String getUserID(String evaluationID) { // 특정 강의평가 작성 사용자 아이디 가져오는 함수
		String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // 아이디 값 반환
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null; // 데이터베이스 오류
	}
	
}
