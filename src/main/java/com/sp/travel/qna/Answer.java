package com.sp.travel.qna;

public class Answer {
	private int answerCode;
	private int qnaCode;
	private String answerCreated;
	private String answerContent;
	private int adminIdx;
	private String adminName;
	public int getAnswerCode() {
		return answerCode;
	}
	public void setAnswerCode(int answerCode) {
		this.answerCode = answerCode;
	}
	public int getQnaCode() {
		return qnaCode; 
	}
	public void setQnaCode(int qnaCode) {
		this.qnaCode = qnaCode;
	}
	public String getAnswerCreated() {
		return answerCreated;
	}
	public void setAnswerCreated(String answerCreated) {
		this.answerCreated = answerCreated;
	}
	public String getAnswerContent() {
		return answerContent;
	}
	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	public int getAdminIdx() {
		return adminIdx;
	}
	public void setAdminIdx(int adminIdx) {
		this.adminIdx = adminIdx;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
}
