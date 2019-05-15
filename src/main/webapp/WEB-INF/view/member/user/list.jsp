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

<h1 id="page_tit">회원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>회원관리</h2>
	<p><strong>고객리스트</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/member/user/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/member/user/list" method="post">
		<div class="list_search">
			<select title="활성여부" name="enabled">
				<option value="2" ${enabled == '2' ? "selected='selected'" : ""}>전체</option>
				<option value="1" ${enabled == '1' ? "selected='selected'" : ""}>활성화</option>
				<option value="0" ${enabled == '0' ? "selected='selected'" : ""}>비활성</option>
			</select>
			<select title="검색조건선택" name="searchKey">
				<option value="userId" ${searchKey == 'userId' ? "selected='selected'" : ""}>아이디</option>
           		<option value="userName" ${searchKey == 'userName' ? "selected='selected'" : ""}>이름</option>
           		<option value="userTel" ${searchKey == 'userTel' ? "selected='selected'" : ""}>전화번호</option>
           		<option value="userEmail" ${searchKey == '"userEmail"' ? "selected='selected'" : ""}>이메일</option>
           		<option value="roleCodeName" ${searchKey == 'roleCodeName' ? "selected='selected'" : ""}>등급</option>
           		<option value="userCreated_date" ${searchKey == 'userCreated_date' ? "selected='selected'" : ""}>가입일</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>고객 리스트</caption>
	<colgroup>
		<col style="width:5%" />
		<col style="width:8%" />
		<col style="width:8%"/>
		<col style="width:10%" />
		<col style="width:8%" />
		<col style="width:5%" />
		<col style="width:5%" />
		<col style="width:7%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">고객정보</th>
			<th scope="col">전화번호</th>
			<th scope="col">이메일</th>
			<th scope="col">등급</th>
			<th scope="col">생일</th>
			<th scope="col">블랙리스트</th>
			<th scope="col">가입일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td><a href="${articleUrl}&userIdx=${dto.userIdx}" class="udline">${dto.userId}(${dto.userName})</a></td>
				<td>${dto.userTel}</td>
				<td>${dto.userEmail}</td>
				<td>${dto.roleCodeName}(${dto.roleCode})</td>
				<td>${dto.userBirth}</td>
				<td>${dto.blackCount == 0 ? '유저' : '블랙리스트'}</td>
				<td>${dto.userCreated_date}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty list}">
			<tr>
				<td colspan="8">등록된 정보가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<div class="t_center mt30">
	${paging}
</div>