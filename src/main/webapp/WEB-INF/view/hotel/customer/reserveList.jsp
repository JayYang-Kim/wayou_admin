<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

$(function(){

    $("#start").datepicker();
    $("#end").datepicker();

});


function searchList1() {
	
	var d=document.searchDate;
	d.submit();
	
}

function searchList2() {
	var f=document.searchForm;
	f.submit();
	
}


</script>

<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>고객관리</strong></p>
</div>

<div class="body" style="height: 800px;">
	<form name="searchDate" action="<%=cp%>/hotel/customer/reserveList" method="post">
	<div class="list_search_wrap">
		<div class="list_search">
			날짜검색&nbsp;
			<span><input type="text" name="start" id="start" value="${dto.use_start}"></span>
			~
			<span><input type="text" name="end" id="end" value="${dto.use_end}"></span>
			<span class="btn">
				<a href="#" class="button" style="border: none;" onclick="searchList1()">검색</a>
			</span>
		</div>
	</div>
	</form>
	<form name="searchForm" action="<%=cp%>/hotel/customer/reserveList" method="post">
	<div class="list_search_wrap">
		<div class="list_search">
			<select name="searchKey" id="searchKey" title="검색조건선택">
				<option value="all">전체</option>
				<option value="hname">호텔명</option>
				<option value="reserveCode">예약번호</option>
				<option value="userName">예약자명</option>
			</select>
			<input type="text" name="searchValue" id="searchValue" title="검색내용입력" />
			<span class="btn">
				<a href="#" class="button" style="border: none;" onclick="searchList2()">검색</a>
			</span>
		</div>
	</div>
	</form>
		<table class="table td_bor_no">
			<thead>
				<tr>
					<th width="50">예약번호</th>
					<th width="50">예약자명</th>
					<th width="50">호텔명</th>
					<th width="50">객실호수</th>
					<th width="70">숙박일자</th>
					<th width="50">예약일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.reserveCode}</td>
						<td>${dto.userName}</td>
						<td>${dto.hName}</td>
						<td>${dto.roomNum}</td>
						<td>${dto.checkIn}-${dto.checkOut}</td>
						<td>${dto.reservation}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>	