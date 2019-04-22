<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

function sendRoom(mode) {
    var f = document.insertRoomForm;
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
		f.action="<%=cp%>/hotel/hotelInfo/roomInfo/insertRoom";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/hotelInfo/roomInfo/updateRoom";
	}
 
	
    f.submit();

}

</script>

<div style="height: 50px; margin-left: 20px;">
		<h1>${hname} 객실 등록</h1>
</div>
<div>
<form name="insertRoomForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
		<tr>
			<th>객실 호수</th>
			<td><input type="text" value="${dto.roomNum}"></td>
		</tr>
	 	<tr>
	 		<th>룹타입</th>
	 		<td>
	 			<select id="roomtypeCode" name="roomtypeCode">
	 				<option value="1" ${dto.locCode=="1"?"selected='selected'":""}>싱글</option>
    				<option value="2" ${dto.locCode=="2"?"selected='selected'":""}>더블</option>
    				<option value="3" ${dto.locCode=="3"?"selected='selected'":""}>트윈</option>
	 			</select>
	 		</td>
	 	</tr>
	 	<tr>
			<th>최대 인원</th>
			<td><input type="text" value="${dto.hCount}"></td>
		</tr>
		<tr>
			<th>가격</th>
			<td><input type="text" value="${dto.price}"></td>
		</tr>
		<tr>
	 		<th>기본정보</th>
	 		<td><textarea name="information">${dto.information}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>공지사항</th>
	 		<td><textarea name="information">${dto.notice}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>취소규정</th>
	 		<td><textarea name="information">${dto.cancel_notice}</textarea></td>
	 	</tr>
      	 	
	 </table>
	 <div class="btn_wrap view_btn">
		
		<button type='button' class='button btn_blk insertHotelSubmit' onclick="sendHotel('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type='button' class='button btn_blk insertHotelCancel' onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/list?hotelCode=${hotel.hotelCode}';">${mode=='update'?'수정취소':'등록취소'}</button>
	 
	 </div>
</form>
</div>