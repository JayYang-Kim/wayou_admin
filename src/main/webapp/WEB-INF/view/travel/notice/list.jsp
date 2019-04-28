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
	<p><strong>공지사항</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/travel/admin/board/notice/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/travel/admin/board/notice/list" method="post">
		<div class="list_search">
			<select title="검색조건선택" name="searchKey">
           		<option value="subject" ${searchKey == 'subject' ? "selected='selected'" : ""}>제목</option>
           		<option value="adminId" ${searchKey == 'adminId' ? "selected='selected'" : ""}>작성자</option>
           		<option value="created" ${searchKey == 'created' ? "selected='selected'" : ""}>작성일</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>공지사항</caption>
	<colgroup>
		<col style="width:4%" />
		<col style="" />
		<col style="width:10%" />
		<col style="width:14%" />
		<col style="width:7%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
			<th scope="col">첨부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>
					<a class="udline" href="${articleUrl}&notiCode=${dto.notiCode}">
						<span>${dto.subject}</span>
					</a>
				</td>
				<td>${dto.adminId}(${dto.adminName})</td>
				<td>${dto.created}</td>
				<td></td>
			</tr>
		</c:forEach>
		<c:if test="${empty list}">
			<tr>
				<td colspan="5">등록된 정보가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<div class="t_center mt30">
	${paging}
</div>
<c:if test="${sessionScope.admin.departCode == 4 || sessionScope.admin.departCode == 3}">
	<div class="btn_wrap">
		<p class="f_right"><a href="<%=cp%>/travel/admin/board/notice/add" class="button h30 btn_brown w70">등록</a></p>
	</div>
</c:if>