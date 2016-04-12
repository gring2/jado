package org.scit.app.vo;

import java.util.List;

public class Gantchart {
	private String gantNum;
	private String proNum;
	private String todo;
	private String startDate;
	private Integer duration;
	private List<String> userNumList;
	
//	public Gantchart(){}
//	
//	
//
//	public Gantchart(String gantNum, String proNum, String todo, String startDate, int duration) {
//		super();
//		this.gantNum = gantNum;
//		this.proNum = proNum;
//		this.todo = todo;
//		this.startDate = startDate;
//		this.duration = duration;
//	}



	public String getGantNum() {
		return gantNum;
	}

	public void setGantNum(String gantNum) {
		this.gantNum = gantNum;
	}

	public String getProNum() {
		return proNum;
	}

	public void setProNum(String proNum) {
		this.proNum = proNum;
	}

	public String getTodo() {
		return todo;
	}

	public void setTodo(String todo) {
		this.todo = todo;
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

	public List<String> getUserNumList() {
		return userNumList;
	}

	public void setUserNumList(List<String> userNumList) {
		this.userNumList = userNumList;
	}



	@Override
	public String toString() {
		return "Gantchart [gantNum=" + gantNum + ", proNum=" + proNum + ", todo=" + todo + ", startDate=" + startDate
				+ ", duration=" + duration + ", userNumList=" + userNumList + "]";
	}
	
	
	
	

	
}
