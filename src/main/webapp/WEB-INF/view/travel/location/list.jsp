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
		<button type="button" class="button" onclick="location.href='<%=cp%>/travel/admin/location/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/travel/admin/location/list" method="post">
		<div class="list_search">
			<select title="활성여부" name="enable">
				<option value="2" ${enable == 2 ? "selected='selected'" : ""}>전체</option>
				<option value="1" ${enable == 1 ? "selected='selected'" : ""}>활성화</option>
				<option value="0" ${enable == 0 ? "selected='selected'" : ""}>비활성</option>
			</select>
			<select title="검색조건선택" name="searchKey">
           		<option value="location" ${searchKey == 'location' ? "selected='selected'" : ""}>지역명</option>
           		<option value="memo" ${searchKey == 'memo' ? "selected='selected'" : ""}>메모</option>
           		<option value="adminId" ${searchKey == 'adminId' ? "selected='selected'" : ""}>아이디</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>지역 리스트</caption>
	<colgroup>
		<col style="width:5%" />
		<col style="width:10%" />
		<col style="width:7%" span="2" />
		<col style="width:7%" />
		<col style="width:4%" />
		<col style="width:8%" />
		<col style="width:7%" />
		<col style="width:4%" />
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
			<th scope="col">첨부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>
					<a class="udline" href="${articleUrl}&locCode=${dto.locCode}">
						<span>${dto.locName}</span>(${dto.locCode})
					</a>
				</td>
				<td>${dto.lat}</td>
				<td>${dto.lng}</td>
				<td>${dto.memo}</td>
				<td>${dto.enable == 1 ? "활성화" : "비활성"}</td>
				<td>${dto.adminId}<br/>(${dto.adminName})</td>
				<td>${dto.created}</td>
				<td>
					<c:if test="${not empty dto.saveFilename}">
						<img src="<%=cp%>/resource/images/common/file_img.png" alt="첨부 이미지" style="width:18px;"/>
					</c:if>
				</td>
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
<c:if test="${sessionScope.admin.departCode == 4 || sessionScope.admin.departCode == 3}">
	<div class="btn_wrap">
		<p class="f_right"><a href="<%=cp%>/travel/admin/location/add" class="button h30 btn_brown w70">등록</a></p>
	</div>
</c:if>