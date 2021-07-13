package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("rueun0302@gmail.com", "Gk221714k!!"); //관리자 자신의 구글 아이디와 비밀번호 입력
	}

}
