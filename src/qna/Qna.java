package qna;

public class Qna {
	private int qnaID;
	private String qnaTitle;
	private String userID;
	private String userNickname;
	private String qnaDate;
	private String qnaContent;
	private String qnaAnswer;
	private int qnaConfirm;
	public int getQnaID() {
		return qnaID;
	}
	public void setQnaID(int qnaID) {
		this.qnaID = qnaID;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getQnaDate() {
		return qnaDate;
	}
	public void setQnaDate(String qnaDate) {
		this.qnaDate = qnaDate;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public String getQnaAnswer() {
		return qnaAnswer;
	}
	public void setQnaAnswer(String qnaAnswer) {
		this.qnaAnswer = qnaAnswer;
	}
	public int getQnaConfirm() {
		return qnaConfirm;
	}
	public void setQnaConfirm(int qnaConfirm) {
		this.qnaConfirm = qnaConfirm;
	}
	public Qna() {
		
	}
	public Qna(int qnaID, String qnaTitle, String userID, String userNickname, String qnaDate, String qnaContent,
			String qnaAnswer, int qnaConfirm) {
		super();
		this.qnaID = qnaID;
		this.qnaTitle = qnaTitle;
		this.userID = userID;
		this.userNickname = userNickname;
		this.qnaDate = qnaDate;
		this.qnaContent = qnaContent;
		this.qnaAnswer = qnaAnswer;
		this.qnaConfirm = qnaConfirm;
	}
}
