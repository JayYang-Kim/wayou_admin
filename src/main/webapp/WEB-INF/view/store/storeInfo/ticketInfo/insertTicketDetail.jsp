<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<form name="insertTicketDetailForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
	<tbody id="tb">
		<tr>
			<th>상세티켓명</th>
			<td><input type="text" name="ticketDetailName" value="${dto.ticketDetailName}"></td>
		</tr>

	 	<tr>
	 		<th>수량</th>
	 		<td><input type="text" name="count" value="${dto.count}"></td>
	 	</tr>
	 	<tr>
	 		<th>가격</th>
	 		<td><input type="text" name="price" value="${dto.price}"></td>
	 	</tr>
      	
	 	</tbody> 
	 	
	 	
	 </table>
	 <div class="btn_wrap view_btn">
		
		<button type='button' class='button btn_blk insertHTicketSubmit' onclick="sendTicketDetail('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type='button' class='button btn_blk insertHotelCancel' onclick="location.href='#';">${mode=='update'?'수정취소':'등록취소'}</button>
	 	
	 </div>
	 
	 <input type="hidden" name="ticketCode" value="${ticketCode}">
	 <c:if test="${mode=='update'}">
	 	<input type="hidden" name="storeCode" value="${dto.storeCode}">
	 </c:if>
</form>
