<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript" src="<%=cp %>/resource/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

function insertOk(){
	var f=document.createdFrom;
	var content;
	
	content=f.subject.value;
	if(!content){
		alert("제목을 입력해주세요");
		f.subject.focus();
		return;
	}
	
	oEditors1.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors2.getById["memo"].exec("UPDATE_CONTENTS_FIELD", []);
	
	content=f.content.value;
	if(!content){
		alert("일지 내용을 입력해주세요");
		f.content.focus();
		return;
	}
	
	content=f.memo.value;
	if(!content){
		alert("건의사항 및 특이사항을 입력해주세요");
		f.memo.focus();
		return;
	}
	
	
	var mode = "${mode}";
	
	if(mode == "created") {
		f.action = "<%=cp%>/work/${mode}";	
	} else if(mode == "update") {
		f.action = "<%=cp%>/work/${mode}";
	}
	
	f.submit();
}


</script>

<h1 id="page_tit">직원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>근무 관리</h2>
	<p><strong>근무 일지 작성</strong></p>
</div>

<form name="createdFrom" method="post">
	<table class="table left_tbl form_tbl">
		<colgroup>
			<col style="width:20%"/>
			<col />
			<col style="width:20%"/>
			<col />
		</colgroup>
<tbody>
	<tr>
		<th scope="row">제목</th>
		<td>
			<input type="text" name="subject" style="width:250px" value="${dto.subject}">
		</td>
		<th scope="row">부서</th>
		<td>
			<c:if test="${mode == 'update'}">
			<input type="hidden" name="diaryCode" value="${dto.diaryCode}">
			</c:if>
			<input type="hidden" name="dapartName" value="${dto.departName}">
			<input type="hidden" name="adminIdx" value="${mode == 'created' ? di.adminIdx : dto.adminIdx}">
			${mode == 'created' ? di.departName : dto.departName}
		</td>
	</tr>
		<tr>
		<th scope="row">작성자</th>
		<td>
			${mode == 'created' ? di.adminName : dto.adminName}
		</td>
		<th scope="row">직책</th>
		<td>
			<input type="hidden" name="positionName" value="${dto.positionName}">
			${mode == 'created' ? di.positionName : dto.positionName}
		</td>
	</tr>
	<tr>
		<th>금일 문의 건수</th>
		<td>${mode == 'created' ? di.dayWork : dto.dayWork}건
		<input type="hidden" name="dayWork" value="${mode == 'created' ? di.dayWork : dto.dayWork}"> </td>
		<th>금일 답변 건수</th>
		<td>${mode == 'created' ? di.finishWork : dto.finishWork}건
		<input type="hidden" name="dayWork" value="${mode == 'created' ? di.finishWork : dto.finishWork}"></td>
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">일지 내용</th>
	</tr>
	<tr>
		<td colspan="4">
	<textarea name="content" id="content" rows="10" cols="100" style="width:95%;">${dto.content}</textarea>
		</td>
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">특이 사항 / 건의 사항</th>
	</tr>
	<tr>
		<td colspan="4">
		<textarea name="memo" id="memo" rows="10" cols="10" style="width:95%;">${dto.memo}</textarea>
		</td>
	</tr>
	</tbody>
</table>
</form>
<div style="text-align:center; margin-top:10px">
<a href="<%=cp%>/work/list${query}" class="button h30 w70 btn_wht">돌아가기</a>
<button type="button" class="button h30 w70 btn_wht" onclick="insertOk()">${mode == 'created' ? '등록' : '수정'}</button>
</div>


<script type="text/javascript">
var oEditors1 = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors1,
 elPlaceHolder: "content",
 sSkinURI: "<%=cp %>/resource/smarteditor/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});

var oEditors2 = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors2,
 elPlaceHolder: "memo",
 sSkinURI: "<%=cp %>/resource/smarteditor/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});
</script>