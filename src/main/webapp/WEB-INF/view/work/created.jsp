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
	
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
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
		f.action = "<%=cp%>/work/${mode}${query}";
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
			<input type="hidden" name="dapartName" value="${dto.departName}">
			<input type="hidden" name="adminIdx" value="${di.adminIdx}">
			${di.departName}
		</td>
	</tr>
		<tr>
		<th scope="row">작성자</th>
		<td>
			${di.adminName}
		</td>
		<th scope="row">직책</th>
		<td>
			<input type="hidden" name="positionName" value="${dto.positionName}">
			${di.positionName}
		</td>
	</tr>
	<tr>
		<th>금일 문의 건수</th>
		<td>${di.dayWork}건
		<input type="hidden" name="dayWork" value="${di.dayWork}"> </td>
		<th>금일 답변 건수</th>
		<td>${di.finishWork}건
		<input type="hidden" name="dayWork" value="${di.finishWork}"></td>
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">일지 내용</th>
	</tr>
	<tr>
		<td colspan="4">
	<textarea name="content" id="content" rows="10" cols="100">${dto.content}</textarea>
		</td>
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">특이 사항 / 건의 사항</th>
	</tr>
	<tr>
		<td colspan="4">
		<textarea  rows="10" cols="10" name="memo">${dto.memo}</textarea>
		</td>
	</tr>
	</tbody>
</table>
</form>
<div style="text-align:center; margin-top:10px">
<button type="button" class="button h30 w70 btn_wht">돌아가기</button>
<button type="button" class="button h30 w70 btn_wht" onclick="insertOk()">등록</button>
</div>


<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "content",
 sSkinURI: "<%=cp %>/resource/smarteditor/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});
</script>