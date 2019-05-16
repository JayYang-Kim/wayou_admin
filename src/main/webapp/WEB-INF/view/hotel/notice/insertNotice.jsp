<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">




function sendNotice(mode) {
    var f = document.insertNoticeForm;
	/* 	
	if(! f.hname.value) {
		alert("호텔명을 입력하세요.");
		f.hname.focus();
		return;
	}
	
	if(! f.address1.value) {
		f.address1.focus();
		return;
	}
	
	if(! f.address2.value) {
		f.address2.focus();
		return;
	}
	
	if(! f.email.value) {
		f.email.focus();
		return;
	}
	
	if(! f.tel.value) {
		f.tel.focus();
		return;
	}
  */
	if(mode=="created") {
		f.action="<%=cp%>/hotel/notice/insertNotice";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/hotelInfo/roomInfo/updateRoom";
	}
 
	
    f.submit();

}

</script>

<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>공지사항 등록</strong></p>
</div>
<div>
<form name="insertNoticeForm" method="post">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody id="tb">
		<tr>
			<th><b class="t_red">*</b>제목</th>
			<td><input type="text" name="subject" class="boxTF" style="width: 95%;" value="${dto.subject}"></td>
		</tr>
		<tr>
	 		<th><b class="t_red">*</b>내용</th>
	 		<td><textarea name="content" style="width: 95%; height: 400px;">${dto.content}</textarea></td>
	 	</tr>
	 	</tbody> 

	 </table>
	 <div class="btn_wrap view_btn">
		
		<button type='button' class='button btn_blk insertHotelSubmit' onclick="sendNotice('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type='button' class='button btn_blk insertHotelCancel' onclick="location.href='<%=cp%>/hotel/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
	 	
	 </div>
	 
	 <input type="hidden" name="tname" value="hotel">
</form>
</div>