package org.scit.app.vo;

import java.util.List;

public class User {
	private String usrId;
	private String usrPassword;
	private String usrName;
	private String usrPhone;
	@Override
	public String toString() {
		return "User [usrId=" + usrId + ", usrPassword=" + usrPassword + ", usrName=" + usrName + ", usrPhone="
				+ usrPhone + "]";
	}
	public void getit(List<Object> x){
		System.out.println(x.get(0).toString());
	}
	
}
