package org.scit.app.vo;

import org.springframework.web.multipart.MultipartFile;

public class Storage {
	private String thmNum;
	private String fileName;
	private MultipartFile file;
	private String realPath;
	
	public Storage() {
		// TODO Auto-generated constructor stub
	}

	public Storage(String thmNum, String fileName, MultipartFile file, String realPath) {
		this.thmNum = thmNum;
		this.fileName = fileName;
		this.file = file;
		this.realPath = realPath;
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

	public String getRealPath() {
		return realPath;
	}

	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}

	@Override
	public String toString() {
		return "Storage [thmNum=" + thmNum + ", fileName=" + fileName + ", file=" + file + ", realPath=" + realPath
				+ "]";
	}
	
}
