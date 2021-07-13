package favoritemovie;

public class FavoriteDTO {
	String userID;
	String userLikeaction;
	String userLikemelo;
	String userLikecomedy;
	String userLikeresoning;
	String userLikehorror;
	String userLikefanstasy;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserLikeaction() {
		return userLikeaction;
	}
	public void setUserLikeaction(String userLikeaction) {
		this.userLikeaction = userLikeaction;
	}
	public String getUserLikemelo() {
		return userLikemelo;
	}
	public void setUserLikemelo(String userLikemelo) {
		this.userLikemelo = userLikemelo;
	}
	public String getUserLikecomedy() {
		return userLikecomedy;
	}
	public void setUserLikecomedy(String userLikecomedy) {
		this.userLikecomedy = userLikecomedy;
	}
	public String getUserLikeresoning() {
		return userLikeresoning;
	}
	public void setUserLikeresoning(String userLikeresoning) {
		this.userLikeresoning = userLikeresoning;
	}
	public String getUserLikehorror() {
		return userLikehorror;
	}
	public void setUserLikehorror(String userLikehorror) {
		this.userLikehorror = userLikehorror;
	}
	public String getUserLikefanstasy() {
		return userLikefanstasy;
	}
	public void setUserLikefanstasy(String userLikefanstasy) {
		this.userLikefanstasy = userLikefanstasy;
	}
	
	public FavoriteDTO() {
		
	}
	
	public FavoriteDTO(String userID, String userLikeaction, String userLikemelo, String userLikecomedy,
			String userLikeresoning, String userLikehorror, String userLikefanstasy) {
		super();
		this.userID = userID;
		this.userLikeaction = userLikeaction;
		this.userLikemelo = userLikemelo;
		this.userLikecomedy = userLikecomedy;
		this.userLikeresoning = userLikeresoning;
		this.userLikehorror = userLikehorror;
		this.userLikefanstasy = userLikefanstasy;
	}

}
