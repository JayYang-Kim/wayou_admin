<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	
</script>

<c:if test="${not empty allLocationLog}">
	<c:forEach var="dto" items="${allLocationLog}">
		<div class="title_allLocationLog p10" style="border-top:1px solid #c4c4c4;border-bottom: 1px solid #c4c4c4">
			${dto.created}
		</div>
		<table class="table_allLocationLog table left_tbl">
			<caption>지역 전체 이력현황</caption>
			<colgroup>
				<col style="width:15%">
				<col>
				<col style="width:15%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">작성자</th>
					<td>${dto.adminId}(${dto.adminName})</td>
					<th scope="row">작성일</th>
					<td>${dto.created}</td>
				</tr>
				<tr>
					<th scope="row">위도</th>
					<td>${dto.lat}</td>
					<th scope="row">경도</th>
					<td>${dto.lng}</td>
				</tr>
				<tr>
					<th scope="row">메모</th>
					<td colspan="3">
						<div class="view_cont">
							${dto.memo}
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
</c:if>
<c:if test="${empty allLocationLog}">
	<div>
		<span>등록된 이력 리스트가 없습니다.</span>
	</div>
</c:if>