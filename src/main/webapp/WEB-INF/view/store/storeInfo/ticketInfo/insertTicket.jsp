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
</script>



<form name="insertTicketForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
	<tbody id="tb">
		<tr>
			<th>티켓명</th>
			<td><input type="text" name="ticketName" value="${dto.ticketName}"></td>
		</tr>

		<tr>
	 		<th>티켓정보</th>
	 		<td><textarea name="ticket_info">${dto.ticket_info}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>판매시작날짜</th>
	 		<td><input type="text" name="sales_start" value="${dto.sales_start}"></td>
	 	</tr>
	 	<tr>
	 		<th>판매마감날짜</th>
	 		<td><input type="text" name="sales_end" value="${dto.sales_end}"></td>
	 	</tr>
	 	<tr>
	 		<th>사용시작날짜</th>
	 		<td><input type="text" name="use_start" value="${dto.use_start}"></td>
	 	</tr>
	 	<tr>
	 		<th>사용마감날짜</th>
	 		<td><input type="text" name="use_end" value="${dto.use_end}"></td>
	 	</tr>
      	<tr>
	 		<th>티켓 이미지 등록</th>
	 		<td>
				<input type="file" name="upload" class="boxTF" size="53" accept="image/*" >
			</td>
	 	</tr>
	 	</tbody> 
	 	
	 	<c:if test="${mode=='update'}">
		   <c:forEach var="vo" items="${listFile}">
				  <tr id="f${vo.fileCode}"> 
				      <th>등록된 티켓 이미지</th>
				      <td> 
							${vo.originalFilename}
							| <a href="javascript:deleteFile('${vo.fileCode}');">삭제</a>	        
				      </td>
				  </tr>
		   </c:forEach>
		</c:if>
	 </table>
	 <div class="btn_wrap view_btn">
		
		<button type='button' class='button btn_blk insertHotelSubmit' onclick="sendTicket('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
		<button type='button' class='button btn_blk insertHotelCancel' onclick="location.href='#';">${mode=='update'?'수정취소':'등록취소'}</button>
	 	
	 </div>
	 
	 <input type="hidden" name="storeCode" value="${storeCode}">
	 <c:if test="${mode=='update'}">
	 	<input type="hidden" name="storeCode" value="${dto.storeCode}">
	 </c:if>
</form>
