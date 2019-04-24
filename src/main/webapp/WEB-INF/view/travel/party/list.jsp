<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	function sendSearch() {
		var f = document.search_form;
		f.submit();
	}
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p><strong>여행동료 관리</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/travel/admin/party/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/travel/admin/party/list" method="post">
		<div class="list_search">
			<select title="활성여부" name="enabled">
				<option value="2" ${enabled == '2' ? "selected='selected'" : ""}>전체</option>
				<option value="0" ${enabled == '0' ? "selected='selected'" : ""}>활성화</option>
				<option value="1" ${enabled == '1' ? "selected='selected'" : ""}>비활성</option>
			</select>
			<select title="확인여부" name="confirmCode">
				<option value="3" ${confirmCode == '3' ? "selected='selected'" : ""}>전체</option>
				<option value="0" ${confirmCode == '0' ? "selected='selected'" : ""}>대기</option>
				<option value="1" ${confirmCode == '1' ? "selected='selected'" : ""}>수락</option>
				<option value="2" ${confirmCode == '2' ? "selected='selected'" : ""}>거절</option>
			</select>
			<select title="검색조건선택" name="searchKey">
				<option value="all" ${searchKey == 'all' ? "selected='selected'" : ""}>제목 + 내용</option>
           		<option value="subject" ${searchKey == 'subject' ? "selected='selected'" : ""}>제목</option>
           		<option value="content" ${searchKey == 'content' ? "selected='selected'" : ""}>내용</option>
           		<option value="startDate" ${searchKey == 'startDate' ? "selected='selected'" : ""}>시작일</option>
           		<option value="endDate" ${searchKey == 'endDate' ? "selected='selected'" : ""}>종료일</option>
           		<option value="userId" ${searchKey == 'userId' ? "selected='selected'" : ""}>아이디</option>
           		<option value="userCount" ${searchKey == 'userCount' ? "selected='selected'" : ""}>인원수</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>관리자 리스트</caption>
	<colgroup>
		<col style="width:5%" />
		<col style="width:8%" />
		<col />
		<col style="width:10%" />
		<col style="width:10%" />
		<col style="width:8%" />
		<col style="width:5%" />
		<col style="width:5%" />
		<col style="width:5%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">파티코드</th>
			<th scope="col">제목</th>
			<th scope="col">시작일</th>
			<th scope="col">종료일</th>
			<th scope="col">유저정보</th>
			<th scope="col">참여인원</th>
			<th scope="col">활성여부</th>
			<th scope="col">확인여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>${dto.partyCode}</td>
				<td><a href="${articleUrl}&partyCode=${dto.partyCode}" class="udline">${dto.subject}</a></td>
				<td>${dto.startDate}</td>
				<td>${dto.endDate}</td>
				<td>${dto.userId}<br/>(${dto.userName})</td>
				<td>${dto.max}</td>
				<td>${dto.enabled == 0 ? "활성" : "비활성"}</td>
				<td>${dto.confirmCode == 0 ? "대기" : dto.confirmCode == 1 ? "수락" : "거절"}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty list}">
			<tr>
				<td colspan="9">등록된 정보가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<div class="t_center mt30">
	${paging}
</div>