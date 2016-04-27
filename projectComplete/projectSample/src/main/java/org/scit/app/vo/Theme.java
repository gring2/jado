package org.scit.app.vo;



public class Theme {
	private String thmNum;
	private String proNum;
	private String themeName;
	public Theme() {
	}
	public Theme(String thmNum, String proNum, String themeName) {
		super();
		this.thmNum = thmNum;
		this.proNum = proNum;
		this.themeName = themeName;
	}
	public String getThmNum() {
		return thmNum;
	}
	public void setThmNum(String thmNum) {
		this.thmNum = thmNum;
	}
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	public String getThemeName() {
		return themeName;
	}
	public void setThemeName(String themeName) {
		this.themeName = themeName;
	}
	@Override
	public String toString() {
		return "Theme [thmNum=" + thmNum + ", proNum=" + proNum + ", themeName=" + themeName + "]";
	}
}
