<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div class="body" style="height: 800px;">
	<div style="height: 50px;">
		<h1>예약고객List</h1>
	</div>
	<div class="list_search_wrap">
		<div class="list_search">
			<select title="검색조건선택">
				<option value="전체">전체</option>
				<option value="호텔명">호텔명</option>
				<option value="예약번호">예약번호</option>
				<option value="예약자명">예약자명</option>
				<option value="예약일자">예약일자</option>

			</select>
			<input type="text" title="검색내용입력" />
			<span class="btn">
				<a href="#" class="button" style="border: none;">검색</a>
			</span>
		</div>
	</div>
		<table class="table td_bor_no">
			<thead>
				<tr>
					<th width="50">예약번호</th>
					<th width="50">예약자명</th>
					<th width="50">호텔명</th>
					<th width="50">객실타입</th>
					<th width="70">숙박일자</th>
					<th width="50">예약일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" begin="1" end="10" step="1">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>	