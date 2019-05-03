<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">


$(function() {

	$(".btnInsertTicketDetail").click(function() {	
		
		var isClass = $("#insertForm").hasClass("insertTicketDetail");
		if(isClass) {
			$("#insertForm").removeClass("insertTicketDetail");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/store/storeInfo/ticketInfo/insertDetail";
		var query="ticketCode="+$(this).attr("data-ticketCode");

		$.ajax({
			type:"get",
			url:url,
			data:query,
			dataType : "html",
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertTicketDetail");
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


function sendTicketDetail(mode) {
 
    var f = document.insertTicketDetailForm;
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
		f.action="<%=cp%>/store/storeInfo/ticketInfo/insertDetail";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/store/storeInfo/ticketInfo/updateDetail";
	}
 
	
    f.submit();

}
<%-- 
$(function() {

	$(".btnUpdateTicketDetail").click(function() {	

		var isClass = $("#insertForm").hasClass("insertTicketDetail");
		if(isClass) {
			$("#insertForm").removeClass("insertTicketDetail");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/store/storeInfo/ticketInfo/updateDetail";
		var query="ticketCode="+$(this).attr("data-ticketCode");
		
		$.ajax({
			type:"get",
			url:url,
			data:query,
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertTicketDetail");
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

 --%>
</script>


<h1 id="page_tit">티켓관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>티켓관리</h2>
	<p><strong>티켓 등록ㆍ관리</strong></p>
</div>

<div>
	
	<div class="ticketD-body" style="width: 100%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="100">상세티켓명</th>
					<th width="50">수량</th>
					<th width="70">가격</th>
					<th width="100">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${listTicketDetail}">
					<tr>
						<td>${dto.ticketDetailName}</td>
						<td>${dto.count}</td>
						<td>${dto.price}</td>
						<td><button type='button' class='button btnUpdateTicketDetail' data-ticketCode="${dto.ticketCode}">호텔 정보 수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
				${paging}
			</td>
		   </tr>
		</table>
	</div>
	
	<div>
		<div class="btn_wrap view_btn">
			<button class="button btn_blk" type="button" onclick="location.href='<%=cp%>/store/storeInfo/view?storeCode='${storeCode};">스토어 상세보기로</button>
			<button type='button' class='button btn_blk btnInsertTicketDetail' data-ticketCode="${ticketCode}">상세 티켓 등록</button>
		</div>
		<div id="insertForm" class="mt30">
			
		</div>
	</div>

</div>