package org.scit.app.vo;



public class Vote {
	private String chatNum;
	private String userNum;
	private char agreed;
	
	public Vote() {
	}
	public Vote(String chatNum, String userNum, char agreed) {
		super();
		this.chatNum = chatNum;
		this.userNum = userNum;
		this.agreed = agreed;
	}
	public String getChatNum() {
		return chatNum;
	}
	public void setChatNum(String chatNum) {
		this.chatNum = chatNum;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public char getAgreed() {
		return agreed;
	}
	public void setAgreed(char agreed) {
		this.agreed = agreed;
	}
	@Override
	public String toString() {
		return "Vote [chatNum=" + chatNum + ", userNum=" + userNum + ", agreed=" + agreed + "]";
	}
	
	
	
}
