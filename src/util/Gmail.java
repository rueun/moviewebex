package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("rueun0302@gmail.com", "Gk221714k!!"); //������ �ڽ��� ���� ���̵�� ��й�ȣ �Է�
	}

}
