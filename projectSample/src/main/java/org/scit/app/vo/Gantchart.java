package org.scit.app.vo;

import java.util.List;

public class Gantchart {
	private String gantNum;
	private String todo;
	private String proNum;
	
	private List<GantMember> gantMemberList;
	public String getGantNum() {
		return gantNum;
	}
	public void setGantNum(String gantNum) {
		this.gantNum = gantNum;
	}
	
	public String getTodo() {
		return todo;
	}
	public void setTodo(String todo) {
		this.todo = todo;
	}
	
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	
	public List<GantMember> getGantMemberList() {
		return gantMemberList;
	}
	public void setGantMemberList(List<GantMember> gantMemberList) {
		this.gantMemberList = gantMemberList;
	}
	@Override
	public String toString() {
		return "Gantchart [gantNum=" + gantNum + ", todo=" + todo + ", proNum=" + proNum + ", gantMemberList="
				+ gantMemberList + "]";
	}
	
	
	

	
}
