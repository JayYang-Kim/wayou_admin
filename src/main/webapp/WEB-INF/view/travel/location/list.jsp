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
	<p><strong>지역관리</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='#">새로고침</button>
	</div>
	<form name="search_form" action="#" method="post">
		<div class="list_search">
			<select title="검색조건선택" name="searchKey">
           		<option value="location" ${searchKey == 'location' ? "selected='selected'" : ""}>지역명</option>
           		<option value="memo" ${searchKey == 'memo' ? "selected='selected'" : ""}>메모</option>
           		<option value="enable" ${searchKey == 'enable' ? "selected='selected'" : ""}>활성여부</option>
           		<option value="writer" ${searchKey == 'writer' ? "selected='selected'" : ""}>작성자</option>
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
		<col style="" />
		<col style="" />
		<col style="" />
		<col style="" />
		<col style="" />
		<col style="" />
		<col style="" />
		<col style="" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">지역명</th>
			<th scope="col">위도</th>
			<th scope="col">경도</th>
			<th scope="col">메모</th>
			<th scope="col">활성여부</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td><a class="udline" href="#">00000000</a></td>
			<td>33</td>
			<td>33</td>
			<td>메모장</td>
			<td>활성</td>
			<td>어드민</td>
			<td>2019-04-19</td>
		</tr>
	</tbody>
</table>
<div class="t_center mt30">
	<ul class="pagination">
		<li class="disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
		<li class="disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li>
		<li class="active"><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>
		<li><a href="#">5</a></li>
		<li><a href="#"><i class="fa fa-angle-right"></i></a></li>
		<li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
	</ul>
</div>
<div class="btn_wrap">
	<p class="f_right"><a href="<%=cp%>/travel/admin/location/add" class="button h30 btn_brown w70">등록</a></p>
</div>