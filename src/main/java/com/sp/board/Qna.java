package com.sp.board;

public class Qna {
	private int listNum; //리스트번호
	private int qnaCode; //문의코드
	private int catCode; //카테고리코드
	private String subject; //제목
	private String created; //작성일
	private String content; //내용
	private int isSatisfied; //만족여부
	private int userIdx; //고객코드
	private String userName; //작성자
	private int hitCount; // 조회수
	private int answerCount; // 답변 카운트 (0 : 대기, 1이상 : 답변 완료)
	private int adminIdx;
	private String adminId;
	private String adminName;
	private String answerCreated; //답변 작성일
	private String answerContent; //답변 내용
	
	
	
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getQnaCode() {
		return qnaCode;
	}
	public void setQnaCode(int qnaCode) {
		this.qnaCode = qnaCode;
	}
	public int getCatCode() {
		return catCode;
	}
	public void setCatCode(int catCode) {
		this.catCode = catCode;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIsSatisfied() {
		return isSatisfied;
	}
	public void setIsSatisfied(int isSatisfied) {
		this.isSatisfied = isSatisfied;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
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
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public int getAdminIdx() {
		return adminIdx;
	}
	public void setAdminIdx(int adminIdx) {
		this.adminIdx = adminIdx;
	}
}
