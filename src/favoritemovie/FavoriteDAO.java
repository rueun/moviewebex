package favoritemovie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class FavoriteDAO {
	// ��ȭ �帣 ��ȣ
	public int favoritemovie(String userID, String userLikeaction, String userLikemelo, String userLikecomedy, String userLikeresoning,
			String userLikehorror, String userLikefanstasy) {
		String SQL = "INSERT INTO FAVORITEMOVIE VALUES (?, ?, ?, ?, ?, ?, ? )";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userLikeaction);
			pstmt.setString(3, userLikemelo);
			pstmt.setString(4, userLikecomedy);
			pstmt.setString(5, userLikeresoning);
			pstmt.setString(6, userLikehorror);
			pstmt.setString(7, userLikefanstasy);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // �����ͺ��̽� ����
	}
	
	// ��ȭ �帣 ��ȣ ����
	public int modifyfavorite(String userID, String userLikeaction, String userLikemelo, String userLikecomedy, 
			String userLikeresoning, String userLikehorror, String userLikefanstasy ) {
		String SQL = "UPDATE FAVORITEMOVIE SET action = ?, melo = ?, comedy = ?, reasoning = ?, horror = ?, fantasy = ? WHERE userID = ?";	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userLikeaction);
			pstmt.setString(2, userLikemelo);
			pstmt.setString(3, userLikecomedy);
			pstmt.setString(4, userLikeresoning);
			pstmt.setString(5, userLikehorror);
			pstmt.setString(6, userLikefanstasy);
			pstmt.setString(7, userID);
			System.out.println(pstmt);
			pstmt.executeUpdate();
			return 1; // ��������
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return 0; // �����ͺ��̽� ����
	}
		
	// ȸ��Ż��
	public int deleteuser(String userID) {
		String SQL = "DELETE FROM FAVORITEMOVIE WHERE userID = ?";
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
		return -1; // �����ͺ��̽� ����
	}
	
	// �׼� ��ȭ ��ȣ�� ����
	public String getUserLikeaction(String userID) {
		String SQL = "SELECT action FROM FAVORITEMOVIE WHERE userID = ?";
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
		return null; // �����ͺ��̽� ����
	}
	
	// ��� ��ȭ ��ȣ�� ����
	public String getUserLikemelo(String userID) {
		String SQL = "SELECT melo FROM FAVORITEMOVIE WHERE userID = ?";
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
		return null; // �����ͺ��̽� ����
	}
	
	// �ڸ޵� ��ȭ ��ȣ�� ����
		public String getUserLikecomedy(String userID) {
			String SQL = "SELECT comedy FROM FAVORITEMOVIE WHERE userID = ?";
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
			return null; // �����ͺ��̽� ����
		}
		
		// �߸� ��ȭ ��ȣ�� ����
		public String getUserLikereasoning(String userID) {
			String SQL = "SELECT reasoning FROM FAVORITEMOVIE WHERE userID = ?";
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
			return null; // �����ͺ��̽� ����
		}
		
		// ȣ�� ��ȭ ��ȣ�� ����
		public String getUserLikehorror(String userID) {
			String SQL = "SELECT horror FROM FAVORITEMOVIE WHERE userID = ?";
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
			return null; // �����ͺ��̽� ����
		}
		
		// ��Ÿ�� ��ȭ ��ȣ�� ����
		public String getUserLikefantasy(String userID) {
			String SQL = "SELECT fantasy FROM FAVORITEMOVIE WHERE userID = ?";
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
			return null; // �����ͺ��̽� ����
		}
	
	
	
	
	
	
	
}
