<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>여행동료 관리 &gt; <strong>상세정보</strong></p>
</div>

<table class="table left_tbl">
	<caption>여행동료 상세정보</caption>
	<colgroup>
		<col style="width:15%">
		<col>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3">${dto.subject}</td>
		</tr>
		<tr>
			<th scope="row">작성일</th>
			<td>${dto.created}</td>
			<th scope="row">작성자</th>
			<td>${dto.userName} (${dto.userId})</td>
		</tr>
		<tr>
			<th scope="row">시작일</th>
			<td>${dto.startDate}</td>
			<th scope="row">종료일</th>
			<td>${dto.endDate}</td>
		</tr>
		<tr>
			<th scope="row">활성여부</th>
			<td>${dto.enabled == 0 ? "활성" : "비활성"}</td>
			<th scope="row">확인여부</th>
			<td></td>
		</tr>
		<tr>
			<th scope="row">내용</th>
			<td colspan="3">
				<div class="view_cont">
					${dto.content}
				</div>
			</td>
		</tr>
	</tbody>
</table>
<div class="btn_wrap view_btn">
	<a href="#" class="button btn_blk h35">저장</a>
</div>
<div class="mt20 mb20">
	<h3>참가현황 : ${dto.partyPeopleCount} / ${dto.max}</h3>
</div>
<div class="tbl_btn">
	<p class="f_left">
		<c:if test="${not empty preReadParty}">
			<a href="<%=cp%>/travel/admin/party/view?${query}&partyCode=${preReadParty.partyCode}" class="button h30 w70 btn_wht">이전</a>
		</c:if>
		<c:if test="${not empty nextReadParty}">
			<a href="<%=cp%>/travel/admin/party/view?${query}&partyCode=${nextReadParty.partyCode}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
	</p>
	<p class="f_right">
		<a href="<%=cp%>/travel/admin/party/list?${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>