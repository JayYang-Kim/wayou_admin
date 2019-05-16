<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
 


$(function() {

	$(".btnInsertTicket").click(function() {	
		
		var isClass = $("#insertForm").hasClass("insertTicket");
		if(isClass) {
			$("#insertForm").removeClass("insertTicket");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/store/storeInfo/ticketInfo/insertTicket";
		var query="storeCode="+$(this).attr("data-storeCode");
		$.ajax({
			type:"get",
			url:url,
			data:query,
			dataType : "html",
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertTicket");
			},
			beforeSend:function(e) {
				e.setRequestHeader("AJAX", true);
			},
			error:function(e) {
				if(e.status==403){
					location.href="<%=cp%>/wadmin/admin/login";
					return;
				}
				console.log(e.responseText);
			}
		});
	});
	
	
});

$(function() {

	$(".btnUpdateTicket").click(function() {	

		var isClass = $("#insertForm").hasClass("insertTicket");
		if(isClass) {
			$("#insertForm").removeClass("insertTicket");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/store/storeInfo/ticketInfo/updateTicket";
		var query="storeCode="+$(this).attr("data-storeCode")+"&ticketCode="+$(this).attr("data-ticketCode");
		
		$.ajax({
			type:"get",
			url:url,
			data:query,
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertTicket");
			},
			beforeSend:function(e) {
				e.setRequestHeader("AJAX", true);
			},
			error:function(e) {
				if(e.status==403){
					location.href="<%=cp%>/wadmin/admin/login";
					return;
				}
				console.log(e.responseText);
			}
		});
	});
	
	
});


function sendTicket(mode) {
    var f = document.insertTicketForm;
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
		f.action="<%=cp%>/store/storeInfo/ticketInfo/insertTicket";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/hotelInfo/updateHotel";
	}
 
	
    f.submit();

}







	

</script>  



<h1 id="page_tit">티켓관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>티켓관리</h2>
	<p><strong>티켓 등록ㆍ관리</strong></p>
</div>

<table class="table left_tbl">
	<caption>스토어 상세정보</caption>
	<colgroup>
		<col style="width:15%">
		<col>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">스토어명</th>
			<td colspan="3">${dto.storeName}</td>
		</tr>
		<tr>
			<th scope="row">카테고리</th>
			<td>${dto.categoryName}</td>
			<th scope="row">지역</th>
			<td>${dto.locName}</td>
		</tr>
		<tr>
			<th scope="row">전화번호</th>
			<td>${dto.tel}</td>
			<th scope="row">이메일</th>
			<td>${dto.email}</td>
		</tr>
		<tr>
			<th scope="row">주소</th>
			<td>${dto.address1}&nbsp;${dto.address2}</td>
			<th scope="row">대표자명</th>
			<td>${dto.name}</td>
		</tr>
		<c:if test="${not empty listStoreFile}">
			<c:forEach var="dto_storeFile" items="${listStoreFile}">
				<tr>
					<th scope="row">이미지</th>
					<td colspan="3">${dto_storeFile.originalFilename}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listStoreFile}">
			<tr>
				<th scope="row">이미지</th>
				<td colspan="3"></td>
			</tr>
		</c:if>
		<tr>
			<th scope="row">기본정보</th>
			<td colspan="3">
				<div>
					${dto.information}
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">공지사항</th>
			<td colspan="3">
				<div>
					${dto.notice}
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">취소규정</th>
			<td colspan="3">
				<div>
					${dto.cancel_notice}
				</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="tbl_btn">
	
	<button class="button btn_blk" type="button" onclick="location.href='<%=cp%>/store/storeInfo/list';">스토어 목록으로</button>
		<c:if test="${sessionScope.admin.departCode == 4 || sessionScope.admin.departCode == 2}">
			<button type="button" class="btn_update button btn_wht" onclick="layerShow('#popup')">수정</button>
			<button type="button" class="btn_delete button btn_red" onclick="layerShow('#popup')">삭제</button>
			
		</c:if>
			
</div>

<div class="ticket-list" style="width: 100%; margin-top: 15px;">
<div>
	<h3 style="float:left;">티켓 리스트</h3>
	<p style="float: right; padding-bottom: 10px;"><button type='button' class='button btn_blk btnInsertTicket' data-storeCode="${dto.storeCode}">티켓 등록하기</button></p>
</div>


	<table class="table td_bor_no" style="width: 100%;">
		<thead>
			<tr>
				<th width="100">티켓명</th>
				<th width="100">판매일</th>
				<th width="100" colspan="2">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto_ticket" items="${listTicket}">
				<tr>
					<td>${dto_ticket.ticketName}</td>
					<td>${dto_ticket.sales_start} - ${dto_ticket.sales_end}</td>
					<td><button type='button' class='button btnUpdateTicket' data-ticketCode="${dto_ticket.ticketCode}" data-storeCode="${dto_ticket.storeCode}">티켓 정보 수정</button></td>
					<td><button type='button' class='button btnInsertRoom' onclick="location.href='<%=cp%>/store/storeInfo/ticketInfo/detail?storeCode=${dto.storeCode}&ticketCode=${dto_ticket.ticketCode}';">티켓 상세 추가ㆍ수정</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="insertForm" class="mt30">
			
	</div>
</div>
	