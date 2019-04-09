<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script>




</script>

<div class="body" style="height: 1200px;">
	<div style="height: 50px; margin-left: 20px;">
		<h1>4월 예약내역</h1>
	</div>
	<div style="overflow-x:scroll; white-space:nowrap; width: 95%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="120">호텔명</th>
					<th width="70">객실타입</th>
					<th width="50">객실호수</th>
					<c:forEach var="i" begin="1" end="30" step="1">
						<th width="50">${i}일</th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" begin="1" end="15" step="1">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<c:forEach var="i" begin="1" end="30" step="1">
							<td>&nbsp;</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div>
		<div id="insert-hotel">
			
		</div>
	</div>

</div>