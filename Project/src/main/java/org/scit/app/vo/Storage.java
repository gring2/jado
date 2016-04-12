package org.scit.app.vo;



public class Storage {
	private String userNum;
	private String proNum;
	private String fileName;
	
	public Storage() {
	}
	public Storage(String userNum, String proNum, String fileName) {
		super();
		this.userNum = userNum;
		this.proNum = proNum;
		this.fileName = fileName;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	@Override
	public String toString() {
		return "Storage [userNum=" + userNum + ", proNum=" + proNum + ", fileName=" + fileName + "]";
	}
	
	
	
	
}
