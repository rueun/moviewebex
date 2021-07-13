package qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class QnaDAO {
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
	
	// QnA ��ȣ ��ȯ �Լ�
	public int getNext() {
		String SQL = "SELECT qnaID FROM QNA ORDER BY qnaID DESC";
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
	
	// �ڽ��� ���ǳ��� ��� ���
	public ArrayList<Qna> getList(int pageNumber, String userID) {
		String SQL = "SELECT * FROM QNA WHERE qnaID < ? AND userID = ? ORDER BY qnaID DESC LIMIT 5";
		ArrayList<Qna> list = new ArrayList<Qna>(); // select�� ������ ���� �� �ִ� ����Ʈ ����
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery(); // ���� ���������� ������ ���
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
				list.add(qna); // ����Ʈ�� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 5�� �̾ƿ� ������ ����Ʈ ��ȯ
	}
	
	// �����ڿ� ��� ���ǳ��� ��� ���
	public ArrayList<Qna> getListAll(int pageNumber) {
		String SQL = "SELECT * FROM QNA WHERE qnaID < ? ORDER BY qnaID DESC LIMIT 10";
		ArrayList<Qna> list = new ArrayList<Qna>(); // select�� ������ ���� �� �ִ� ����Ʈ ����
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;			
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // ���� ���������� ������ ���
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
				list.add(qna); // ����Ʈ�� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 10�� �̾ƿ� ������ ����Ʈ ��ȯ
	}
	
	
	
	// ���ǻ��� ����¡ ó���� ���� �Լ�
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
			if(rs.next()) { // ����� �ϳ��� �����Ѵٸ�
				return true; // ���� �������� �Ѿ �� ������ �˷���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // ���� �������� �Ѿ �� ����
	}
	
	// Ư�� ���� ��ȣ�� �ϳ��� ���� ���� ��������
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
			if(rs.next()) { // qna �ν��Ͻ��� ���� �� �־ ��ȯ
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
		return null; // ���� �� �ΰ� ��ȯ�ϱ�
	}
	
	// ���ǻ��� ����
	public int delete(int noticeID) {
		String SQL = "DELETE FROM QNA WHERE qnaID = ? ";
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
	
	
	// �亯 ���
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
