package org.scit.app.vo;

import java.util.List;

public class Chat {
	private String chatNum;
	private String userNum;
	private String proNum;
	private String thmNum;
	private String content;
	private String chatType;
	private String startDate;
	private String chatDate;
	private List<Vote> voteList;
	public Chat() {
	}
	public Chat(String chatNum, String userNum, String proNum, String thmNum, String content, String chatType,
			String startDate, String chatDate, List<Vote> voteList) {
		super();
		this.chatNum = chatNum;
		this.userNum = userNum;
		this.proNum = proNum;
		this.thmNum = thmNum;
		this.content = content;
		this.chatType = chatType;
		this.startDate = startDate;
		this.chatDate = chatDate;
		this.voteList = voteList;
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
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	public String getThmNum() {
		return thmNum;
	}
	public void setThmNum(String thmNum) {
		this.thmNum = thmNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getChatType() {
		return chatType;
	}
	public void setChatType(String chatType) {
		this.chatType = chatType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getChatDate() {
		return chatDate;
	}
	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}
	public List<Vote> getVoteList() {
		return voteList;
	}
	public void setVoteList(List<Vote> voteList) {
		this.voteList = voteList;
	}
	@Override
	public String toString() {
		return "Chat [chatNum=" + chatNum + ", userNum=" + userNum + ", proNum=" + proNum + ", thmNum=" + thmNum
				+ ", content=" + content + ", chatType=" + chatType + ", startDate=" + startDate + ", chatDate="
				+ chatDate + ", voteList=" + voteList + "]";
	}
}
