package org.scit.app.vo;



public class Scrap {
	private String content;
	private String title;
	private String themeName;
	private String chatDate;
	
	public Scrap() {
	}
	
	public Scrap(String content, String title, String themeName, String chatDate) {
		super();
		this.content = content;
		this.title = title;
		this.themeName = themeName;
		this.chatDate = chatDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getThemeName() {
		return themeName;
	}

	public void setThemeName(String themeName) {
		this.themeName = themeName;
	}

	public String getChatDate() {
		return chatDate;
	}

	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}

	@Override
	public String toString() {
		return "Scrap [content=" + content + ", title=" + title + ", themeName=" + themeName + ", chatDate=" + chatDate
				+ "]";
	}
}
