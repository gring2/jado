package org.scit.app.vo;

public class Message {
	private String sender;
	private String receiver;
	private String content;
	private String startDate;
	private String isinvate;
	public String getIsinvate() {
		return isinvate;
	}
	public void setIsinvate(String isinvate) {
		this.isinvate = isinvate;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	@Override
	public String toString() {
		return "Message [sender=" + sender + ", receiver=" + receiver + ", content=" + content + ", startDate="
				+ startDate + "]";
	}
}

