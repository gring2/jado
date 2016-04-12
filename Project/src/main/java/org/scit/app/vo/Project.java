package org.scit.app.vo;

public class Project {
	private String proNum;
	private String title;
	private String startDate;
	private String endDate;
	private String agreed;
	
	public Project() {
	}
	public Project(String proNum, String title, String startDate, String endDate, String agreed) {
		super();
		this.proNum = proNum;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.agreed = agreed;
	}
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAgreed() {
		return agreed;
	}
	public void setAgreed(String agreed) {
		this.agreed = agreed;
	}
	@Override
	public String toString() {
		return "Project [proNum=" + proNum + ", title=" + title + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", agreed=" + agreed + "]";
	}
}
