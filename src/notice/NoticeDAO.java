package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class NoticeDAO {
	
	public String getDate() { // ���� �ð� ��������
		String SQL = "SELECT NOW()";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // �������������� ������ ���
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �����ͺ��̽� ����
	}
	
	// �Խù� ��ȣ ��ȯ �Լ�
	public int getNext() {
		String SQL = "SELECT noticeID FROM NOTICE ORDER BY noticeID DESC";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // ���� ���������� ������ ���
			if (rs.next()) {
				return rs.getInt(1) + 1; // ���� �Խù� ��ȣ �޾ƿͼ� 1�� ������ ���� ��ȯ
			}
			return 1; // ù��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
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
			return pstmt.executeUpdate(); // ������ 0�̻��� �� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // �����ͺ��̽� ����
	}
	
	
	// ������ ��� ���
	public ArrayList<Notice> getList(int pageNumber) {
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 5";
		ArrayList<Notice> list = new ArrayList<Notice>(); // select�� ������ ���� �� �ִ� ����Ʈ ����
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // ���� ���������� ������ ���
			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setManagerID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				list.add(notice); // ����Ʈ�� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 5�� �̾ƿ� ������ ����Ʈ ��ȯ
	}
	
	
	// �������� ����¡ ó���� ���� �Լ�
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
			if(rs.next()) { // ����� �ϳ��� �����Ѵٸ�
				return true; // ���� �������� �Ѿ �� ������ �˷���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // ���� �������� �Ѿ �� ����
	}
	
	
	// Ư�� ������ȣ�� �ϳ��� ���� ���� ��������
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
			if(rs.next()) { // notice �ν��Ͻ��� ���� �� �־ ��ȯ
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
		return null; // ���� �� �ΰ� ��ȯ�ϱ�
	}
	
	
	// �������� ������Ʈ ����
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
			return pstmt.executeUpdate(); // ������ 0 �̻��� �� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // �����ͺ��̽� ����
	}
	
	
	// �������� ����
	public int delete(int noticeID) {
		String SQL = "UPDATE NOTICE SET noticeAvailable = 0 WHERE noticeID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			return pstmt.executeUpdate(); // ������ 0 �̻��� �� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{if(conn != null)  conn.close();} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)  pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)  rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // �����ͺ��̽� ����
	}
	
}
