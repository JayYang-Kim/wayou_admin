<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">


$(function(){
	  $("body").on("change", "input[name=upload]", function(){
		  if(! $(this).val()) {
			  return;	
		  }
		
		  var b=false;
		  $("input[name=upload]").each(function(){
			  if(! $(this).val()) {
				  b=true;
			  	  return;
			  }
		  });
		
		  if(b) return;

		  var $tr, $td, $th, $input;
		
	      $tr=$("<tr>");
	      $th=$("<th>", {style:"border-top:none"});
	      $tr.append($th);
	      $th=$("</th>");
	      $tr.append($th);
	      $td=$("<td>");
	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"height: 25px;"});
	      $td.append($input);
	      $tr.append($td);
	    
	      $("#tb").append($tr);
	  });
});

function deleteFile(fileCode) {
	
	if(confirm("이미지를 삭제하시겠습니까?")){
		var url="<%=cp%>/hotel/hotelInfo/roomInfo/deleteFile";
		$.post(url, {fileCode : fileCode}, function(data) {
			$("#f"+fileCode).remove();
		}, "json");
	}
	
}


function sendRoom(mode) {
    var f = document.insertRoomForm;
	
	if(! f.roomNum.value) {
		alert("룸 호수를 입력하세요.");
		f.roomNum.focus();
		return;
	}
	
	if(! f.roomtypeCode.value) {
		alert("룹 타입을 선택하세요.");
		f.roomtypeCode.focus();
		return;
	}
	
	if(! f.hCount.value) {
		alert("최대 인원을 입력하세요.");
		f.hCount.focus();
		return;
	}
	
	if(! f.price.value) {
		alert("가격을 입력하세요.");
		f.price.focus();
		return;
	}
	
	if(! f.information.value) {
		alert("기본정보를 입력하세요.");
		f.information.focus();
		return;
	}
	
	if(! f.notice.value) {
		alert("공지사항을 입력하세요.");
		f.notice.focus();
		return;
	}
	
	if(! f.cancel_notice.value) {
		alert("취소규정을 입력하세요.");
		f.cancel_notice.focus();
		return;
	}

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
		<h1>${hotel.hname} 객실 등록</h1>
</div>
<div>
<form name="insertRoomForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
	<tbody id="tb">
		<tr>
			<th>객실 호수</th>
			<td><input type="text" name="roomNum" value="${dto.roomNum}"></td>
		</tr>
	 	<tr>
	 		<th>룹타입</th>
	 		<td>
	 			<select id="roomtypeCode" name="roomtypeCode">
	 				<option value="1" ${dto.roomtypeCode=="1"?"selected='selected'":""}>싱글</option>
    				<option value="2" ${dto.roomtypeCode=="2"?"selected='selected'":""}>더블</option>
    				<option value="3" ${dto.roomtypeCode=="3"?"selected='selected'":""}>트윈</option>
	 			</select>
	 		</td>
	 	</tr>
	 	<tr>
			<th>최대 인원</th>
			<td><input type="text" name="hCount" value="${dto.hCount}"></td>
		</tr>
		<tr>
			<th>가격</th>
			<td><input type="text" name="price" value="${dto.price}"></td>
		</tr>
		<tr>
	 		<th>기본정보</th>
	 		<td><textarea name="information">${dto.information}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>공지사항</th>
	 		<td><textarea name="notice">${dto.notice}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>취소규정</th>
	 		<td><textarea name="cancel_notice">${dto.cancel_notice}</textarea></td>
	 	</tr>
      	<tr>
	 		<th>객실 이미지 등록</th>
	 		<td>
				<input type="file" name="upload" class="boxTF" size="53" accept="image/*" >
			</td>
	 	</tr>
	 	</tbody> 
	 	
	 	<c:if test="${mode=='update'}">
		   <c:forEach var="vo" items="${listFile}">
				  <tr id="f${vo.fileCode}"> 
				      <th>등록된 객실 이미지</th>
				      <td> 
							${vo.originalFilename}
							| <a href="javascript:deleteFile('${vo.fileCode}');">삭제</a>	        
				      </td>
				  </tr>
		   </c:forEach>
		</c:if>
	 </table>
	 <div class="btn_wrap view_btn">
		
		<button type='button' class='button btn_blk insertHotelSubmit' onclick="sendRoom('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type='button' class='button btn_blk insertHotelCancel' onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/list?hotelCode=${hotel.hotelCode}';">${mode=='update'?'수정취소':'등록취소'}</button>
	 	
	 </div>
	 
	 <input type="hidden" name="hotelCode" value="${hotel.hotelCode}">
	 <c:if test="${mode=='update'}">
	 	<input type="hidden" name="roomCode" value="${dto.roomCode}">
	 </c:if>
</form>
</div>