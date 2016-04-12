package org.scit.app.vo;



public class User {
	private String userNum;
	private String id;
	private String name;
	private String password;
	private String googleId;	
	
	public User() {
	}
	public User(String userNum, String id, String name, String password, String googleId) {
		super();
		this.userNum = userNum;
		this.id = id;
		this.name = name;
		this.password = password;
		this.googleId = googleId;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGoogleId() {
		return googleId;
	}
	public void setGoogleId(String googleId) {
		this.googleId = googleId;
	}
	@Override
	public String toString() {
		return "User [userNum=" + userNum + ", id=" + id + ", name=" + name + ", password=" + password + ", googleId="
				+ googleId + "]";
	}
}
