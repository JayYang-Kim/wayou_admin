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
		<td>${dto.dayWork}건</td>
		<th>금일 답변 건수</th>
		<td>${dto.finishWork}건</td>
	</tr>
	<tr>
		<th>등록일</th>
		<td>${dto.created}</td>
		<th>수정일</th>
		<td>${dto.modifyDate}</td>
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
<div class="container" style="margin-top:10px" >
	<div class="row">
		<div  class="col-12 col-lg-4">
			<p class="f_right">
			<c:if test="${not empty preArticleWork}">
				<a href="<%=cp%>/work/article${query}&num=${preArticleWork.diaryCode}" class="button h30 w70 btn_wht">이전</a>
			</c:if>
			</p>
		</div>
	<div class="col-12 col-lg-4">
		<p style="text-align:center">
			<a href="<%=cp%>/work/list${query}" class="button h30 w70 btn_wht">돌아가기</a>
			<a href="<%=cp%>/work/update?num=${dto.diaryCode}" class="button h30 w70 btn_wht">수정하기</a>
			<a href="<%=cp%>/work/delete?num=${dto.diaryCode}" class="button h30 w70 btn_red">삭제</a>
		</p>
	</div>
	<div class="col-12 col-lg-4">
		<p class="f_left">
		<c:if test="${not empty nextArticleWork}">
			<a href="<%=cp%>/work/article${query}&num=${nextArticleWork.diaryCode}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
		</p>
	</div>
</div>
</div>
</body>
</html>