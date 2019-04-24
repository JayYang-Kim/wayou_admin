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
	<p><strong>랜드마크 관리</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/travel/admin/landmark/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/travel/admin/landmark/list" method="post">
		<div class="list_search">
			<select title="검색조건선택" name="searchKey">
           		<option value="locName" ${searchKey == 'locName' ? "selected='selected'" : ""}>지역명</option>
           		<option value="landName" ${searchKey == 'landName' ? "selected='selected'" : ""}>랜드마크명</option>
           		<option value="tagName" ${searchKey == 'tagName' ? "selected='selected'" : ""}>태그명</option>
           		<option value="adminId" ${searchKey == 'adminId' ? "selected='selected'" : ""}>아이디</option>
           		<option value="created" ${searchKey == 'created' ? "selected='selected'" : ""}>작성일</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>지역 리스트</caption>
	<colgroup>
		<col style="width:3%" />
		<col style="width:7%" />
		<col style="width:7%" />
		<col style="width:10%" span="2" />
		<col style="width:5%" span="2" />
		<col style="width:8%" />
		<col style="width:7%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">지역정보</th>
			<th scope="col">랜드마크명</th>
			<th scope="col">주소1</th>
			<th scope="col">주소2</th>
			<th scope="col">위도</th>
			<th scope="col">경도</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>${dto.locName}(${dto.locCode})</td>
				<td>
					<a class="udline" href="#">
						<span>${dto.landName}</span>
					</a>
				</td>
				<td>${dto.address1}</td>
				<td>${dto.address2}</td>
				<td>${dto.lat}</td>
				<td>${dto.lng}</td>
				<td>${dto.adminId}(${dto.adminName})</td>
				<td>${dto.created}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="t_center mt30">
	${paging}
</div>
<div class="btn_wrap">
	<p class="f_right"><a href="<%=cp%>/travel/admin/landmark/add" class="button h30 btn_brown w70">등록</a></p>
</div>