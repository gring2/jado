package org.scit.app.vo;

import org.springframework.web.multipart.MultipartFile;

public class Storage {
	private String thmNum;
	private String fileName;
	private MultipartFile file;
	public Storage() {
	}
	@Override
	public String toString() {
		return "Storage [thmNum=" + thmNum + ", fileName=" + fileName + ", file=" + file + "]";
	}
	public String getThmNum() {
		return thmNum;
	}
	public void setThmNum(String thmNum) {
		this.thmNum = thmNum;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}

	
}
