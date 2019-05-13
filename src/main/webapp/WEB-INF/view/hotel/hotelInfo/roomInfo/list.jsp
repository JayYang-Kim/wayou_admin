<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function deleteRoom(roomCode) {
	
	if(confirm("객실을 삭제하시겠습니까?")){
		var url="<%=cp%>/hotel/hotelInfo/roomInfo/deleteRoom?hotelCode=${hotel.hotelCode}&roomCode="+roomCode;
		location.href=url;
	}
	
}
</script>

<div class="body">
	<div style="height: 50px; margin-left: 20px;">
		<h1>${hotel.hname} 객실 목록</h1>
	</div>
	
	</div>
	<div class="hotel-body" style="width: 100%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="70">룸타입</th>
					<th width="70">호수</th>
					<th width="50">인원수</th>
					<th width="50">가격</th>
					<th width="100" colspan="2">관리</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.roomName}</td>
						<td>${dto.roomNum}</td>
						<td>${dto.hCount}</td>
						<td>${dto.price}</td>
						<td><button type='button' class='button btnUpdateHotel' onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/updateRoom?hotelCode=${hotel.hotelCode}&roomCode=${dto.roomCode}';">방 수정</button></td>
						<td><button type='button' class='button btnInsertRoom' onclick="">삭제</button></td>
					</tr>
				</c:forEach>
			
			</tbody>
			
		</table>
		<div class="btn_wrap view_btn">
		<c:if test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">
				<button class="button btn" type="button" onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/insertRoom?hotelCode=${hotel.hotelCode}';">객실 추가하기</button>
		</c:if>		
				<button class="button btn" type="button" onclick="location.href='<%=cp%>/hotel/hotelInfo/list';">호텔 목록으로</button>
		</div>
	</div>