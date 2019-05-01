<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}
</script>
<body>
<h1 id="page_tit">직원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>근무관리</h2>
	<p><strong>근무 일지 리스트</strong></p>
</div>
<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/work/list'">새로고침</button>
	</div>
	<form name="searchForm" action="<%=cp%>/work/list" method="post">
		<div class="list_search">
			<select name="condition">
           		<option value="departCode" ${condition == 'departCode' ? "selected='selected'" : ""}>부서</option>
           		<option value="positionCode" ${condition == 'positionCode' ? "selected='selected'" : ""}>직책</option>
           		<option value="adminName" ${condition == 'adminName' ? "selected='selected'" : ""}>작성자</option>
           		<option value="subject" ${condition == 'subject' ? "selected='selected'" : ""}>제목</option>
           		<option value="created" ${condition == 'created' ? "selected='selected'" : ""}>작성일</option>
			</select>
			<input type="text" name="word" value="${word}" />
			<button type="button" class="button" onclick="searchList()">검색</button>
		</div>
	</form>
</div>
<div class="tbl_wrap">
	<table class="table tbl_hover td_bor_no">
	<colgroup>
		<col style="width:10%"/>
		<col style="width:15%"/>
		<col style="width:15%"/>
		<col style="width:20%"/>
		<col style="width:20%"/>
		<col style="width:20%"/>
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>부서</th>
			<th>직책</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
		<tr>
			<td><a href="${articleUrl}&num=${dto.diaryCode}">${dto.listNum}</a></td>
			<td>${dto.departName}</td>
			<td>${dto.positionName}</td>
			<td>${dto.adminName}</td>
			<td>${dto.subject}</td>
			<td>${dto.created}</td>
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
	
	<div class="btn_wrap">
	<p class="f_right">
		<a href="<%=cp %>/work/created" class="button h30 btn_wht w70">등록하기</a>  
	</p>
	</div>
</div>
</body>