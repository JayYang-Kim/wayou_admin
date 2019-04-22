<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>



<div class="body">
	<div style="height: 50px; margin-left: 20px;">
		<h1>${dto.hname} 객실 목록</h1>
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
			</tbody>
			
		</table>
		<div class="btn_wrap view_btn">
				<button class="button btn" type="button" onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/insertRoom?hotelCode=${dto.hotelCode}';">객실 추가하기</button>
				<button class="button btn" type="button" onclick="location.href='<%=cp%>/hotel/hotelInfo/list';">호텔 목록으로</button>
		</div>
	</div>