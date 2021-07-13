package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	// 로그인 함수
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공	
				}
				else {
					return 0; // 비밀번호 틀림
				}
			}
			return -1; // 아이디 없음
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -2; // 데이터베이스 오류
	}
	
	// 사용자 회원가입 함수
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			pstmt.setString(5, user.getUserNickname());
			pstmt.setString(6, user.getUserGender());
			return pstmt.executeUpdate(); //1이라는 값이 반환되면 회원가입 성공
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 회원가입 실패
	}
	
	
	// 회원정보 수정
	public int modify(String userID, String userPassword, String userNickname) {
		String SQL = "UPDATE USER SET userPassword = ?, userNickname = ? WHERE userID = ?";	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userNickname);
			pstmt.setString(3, userID);
			pstmt.executeUpdate();
			return 1; // 수정성공
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return 0; // 데이터베이스 오류
	}
	
	// 회원탈퇴
	public int deleteuser(String userID) {
		String SQL = "DELETE FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
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
	
	
	
	
	

	// 사용자의 비밀번호를 반환해주는 함수
	public String getUserPassword(String userID) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
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
	
	
	// 사용자의 이메일을 반환해주는 함수
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
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
	
	
	// 사용자의 닉네임을 반환해주는 함수
	public String getUserNickname(String userID) {
		String SQL = "SELECT userNickname FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
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
	
	// 사용자의 성별을 반환해주는 함수
		public String getUserGender(String userID) {
			String SQL = "SELECT userGender FROM USER WHERE userID = ?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;			
			try {
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
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
		
	
	
	
	// 사용자가 이메일 인증을 받았는지 확인
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false; // 데이터베이스 오류
	}
	
	
	
	// 특정한 사용자의 이메일 인증을 수행
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false; // 데이터베이스 오류
	}
	
	
	
	

}
