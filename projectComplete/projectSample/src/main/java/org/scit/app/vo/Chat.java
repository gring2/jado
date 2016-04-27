package org.scit.app.vo;

import java.util.List;

public class Chat {
	private String userNum;
	private String thmNum;
	private String content;
	private String chatType;
	private String chatDate;
	private List<Vote> voteList;
	private String id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Chat() {
	}
	public Chat(String chatNum, String userNum, String proNum, String thmNum, String content, String chatType,
			String startDate, String chatDate, List<Vote> voteList) {
		this.userNum = userNum;
		this.thmNum = thmNum;
		this.content = content;
		this.chatType = chatType;
		this.chatDate = chatDate;
		this.voteList = voteList;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
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
		return "Chat [userNum=" + userNum + ", thmNum=" + thmNum + ", content=" + content + ", chatType=" + chatType
				+ ", chatDate=" + chatDate + ", voteList=" + voteList + ", id=" + id + "]";
	}
	
}
