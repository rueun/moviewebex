package evaluation;

public class EvaluationDTO {
	
	int evaluationID;
	String userID; 
	String movieName;
	String ratingScore; 
	String evaluationTitle; 
	String evaluationContent; 
	String directionScore; 
	String actingScore; 
	String storyScore;
	String visualScore;
	String evaluationDate;
	int likeCount;
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getRatingScore() {
		return ratingScore;
	}
	public void setRatingScore(String ratingScore) {
		this.ratingScore = ratingScore;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getDirectionScore() {
		return directionScore;
	}
	public void setDirectionScore(String directionScore) {
		this.directionScore = directionScore;
	}
	public String getActingScore() {
		return actingScore;
	}
	public void setActingScore(String actingScore) {
		this.actingScore = actingScore;
	}
	public String getStoryScore() {
		return storyScore;
	}
	public void setStoryScore(String storyScore) {
		this.storyScore = storyScore;
	}
	public String getVisualScore() {
		return visualScore;
	}
	public void setVisualScore(String visualScore) {
		this.visualScore = visualScore;
	}
	public String getEvaluationDate() {
		return evaluationDate;
	}
	public void setEvaluationDate(String evaluationDate) {
		this.evaluationDate = evaluationDate;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public EvaluationDTO() {
			
		}
	
	public EvaluationDTO(int evaluationID, String userID, String movieName, String ratingScore, String evaluationTitle,
			String evaluationContent, String directionScore, String actingScore, String storyScore, String visualScore,
			String evaluationDate, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.movieName = movieName;
		this.ratingScore = ratingScore;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.directionScore = directionScore;
		this.actingScore = actingScore;
		this.storyScore = storyScore;
		this.visualScore = visualScore;
		this.evaluationDate = evaluationDate;
		this.likeCount = likeCount;
	}
	
}
