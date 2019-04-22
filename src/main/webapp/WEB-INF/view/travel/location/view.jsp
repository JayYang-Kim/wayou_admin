<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	$(function(){
	
	});
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>지역 관리 &gt; <strong>상세정보</strong></p>
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
			<th scope="row">지역정보</th>
			<td>${dto.locName}(${dto.locCode})</td>
			<th scope="row">활성여부</th>
			<td>${dto.enable}</td>
		</tr>
		<tr>
			<th scope="row">위도</th>
			<td>${dto.lat}</td>
			<th scope="row">경도</th>
			<td>${dto.lng}</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${dto.adminId}(${dto.adminName})</td>
			<th scope="row">작성일</th>
			<td>${dto.created}</td>
		</tr>
		<tr>
			<th scope="row">이미지</th>
			<td colspan="3">${dto.saveFilename}</td>
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
		<a href="<%=cp%>/travel/admin/location/list?${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>

<div class="mt20 mb20">
	<h3>이력현황</h3>
	<table class="table tbl_hover td_bor_no mt20">
		<caption>이력현황</caption>
		<colgroup>
			<col style="width:10%" span="2"/>
			<col style=""/>
			<col style="width:10%"/>
			<col style="width:10%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">위도</th>
				<th scope="col">경도</th>
				<th scope="col">메모</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty listLocationLog}">
				<c:forEach var="dto2" items="${listLocationLog}">
					<tr>
						<td>${dto2.lat}</td>
						<td>${dto2.lng}</td>
						<td>${dto2.memo}</td>
						<td>${dto2.adminId}<br/>(${dto2.adminName})</td>						
						<td>${dto2.created}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty listLocationLog}">
				<tr>
					<td colspan="5">등록된 이력 리스트가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>