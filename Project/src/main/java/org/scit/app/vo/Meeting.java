package org.scit.app.vo;



public class Meeting {
	private String startDate;
	private String themeName;
	private String thmNum;
	public Meeting() {
	}
	public Meeting(String startDate, String themeName, String thmNum) {
		super();
		this.startDate = startDate;
		this.themeName = themeName;
		this.thmNum = thmNum;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getThemeName() {
		return themeName;
	}
	public void setThemeName(String themeName) {
		this.themeName = themeName;
	}
	public String getThmNum() {
		return thmNum;
	}
	public void setThmNum(String thmNum) {
		this.thmNum = thmNum;
	}
	@Override
	public String toString() {
		return "Meeting [startDate=" + startDate + ", themeName=" + themeName + ", thmNum=" + thmNum + "]";
	}
	
	
	
}
