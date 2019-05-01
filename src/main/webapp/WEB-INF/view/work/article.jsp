<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<body>
<h1 id="page_tit">직원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>근무 관리</h2>
	<p><strong>근무 일지 상세</strong></p>
</div>
	<table class="table left_tbl form_tbl">
		<colgroup>
			<col style="width:20%"/>
			<col />
			<col style="width:20%"/>
			<col />
		</colgroup>
<tbody>
	<tr>
		<th scope="row">제목</th>
		<td>
			${dto.subject}
		</td>
		<th scope="row">부서</th>
		<td>
			${dto.departName}
		</td>
	</tr>
	<tr>
		<th>금일 문의 건수</th>
		<td>${dto.dayWork}건
		<th>금일 답변 건수</th>
		<td>${dto.finishWork}건
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">일지 내용</th>
	</tr>
	<tr>
		<td colspan="4">${dto.content}</td>
	</tr>
	<tr>
		<th colspan="4" style="text-align:center">특이 사항 / 건의 사항</th>
	</tr>
	<tr>
		<td colspan="4">${dto.memo}</td>
	</tr>
	</tbody>
</table>
<div style="text-align:center; margin-top:10px">
<button type="button" class="button h30 w70 btn_wht">돌아가기</button>
<button type="button" class="button h30 w70 btn_wht" onclick="localhost.href:'<%=cp%>/work/update?num=${num}'">수정하기</button>
</div>
</body>
</html>