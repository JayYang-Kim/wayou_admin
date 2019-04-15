<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<div style="height: 50px; margin-left: 20px;">
		<h1>이벤트 관리</h1>
</div>
<div class="tbl_wrap">
	<table class="table tbl_hover td_bor_no">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>

</div>
<div class="btn_wrap view_btn">
		<button type='button' class='button btn_blk '>이벤트 등록</button>
</div>