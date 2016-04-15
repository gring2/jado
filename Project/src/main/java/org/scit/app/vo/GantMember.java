package org.scit.app.vo;

public class GantMember {
	
	private String userNum;
	private String gantNum;
	private String startDate;	
	private Integer duration;
	
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getGantNum() {
		return gantNum;
	}
	public void setGantNum(String gantNum) {
		this.gantNum = gantNum;
	}
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public Integer getDuration() {
		return duration;
	}
	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	@Override
	public String toString() {
		return "GantMember [userNum=" + userNum + ", gantNum=" + gantNum + ", startDate=" + startDate + ", duration="
				+ duration + "]";
	}

	
}
