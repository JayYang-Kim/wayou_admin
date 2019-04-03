package com.sp.member;

public class User {
	private int userIdx;
	private int roleCode;
	private String userId;
	private String userPwd;
	private String userName;
	private String postCode;
	private String userAddr1;
	private String userAddr2;
	private String etc;
	private String userTel;
	private String userEmail;
	private String userCreated_date;
	private String userModify_date;
	private int blackCount;
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(int roleCode) {
		this.roleCode = roleCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getUserAddr1() {
		return userAddr1;
	}
	public void setUserAddr1(String userAddr1) {
		this.userAddr1 = userAddr1;
	}
	public String getUserAddr2() {
		return userAddr2;
	}
	public void setUserAddr2(String userAddr2) {
		this.userAddr2 = userAddr2;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserCreated_date() {
		return userCreated_date;
	}
	public void setUserCreated_date(String userCreated_date) {
		this.userCreated_date = userCreated_date;
	}
	public String getUserModify_date() {
		return userModify_date;
	}
	public void setUserModify_date(String userModify_date) {
		this.userModify_date = userModify_date;
	}
	public int getBlackCount() {
		return blackCount;
	}
	public void setBlackCount(int blackCount) {
		this.blackCount = blackCount;
	}
}
