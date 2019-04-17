<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
	function searchAdminList() {
		var f=document.searchForm;
		f.submit();
	}
	
	var ra="${state}";
	if(ra!=""){ 
		alert(ra);
	}
</script>
<h1>| 인사 리스트</h1>

<div>
	<div class="list_search_wrap">
		<div class="list_search">
		<form name="searchForm" action="<%=cp%>/admin/list" method="post">
		<span style="text-align:left">검색 결과 : ${dataCount}명</span>
			<select name="condition" id="condition">
				<option value="departCode" ${condition=="departCode"?"selected='selected' ":""}>부서</option>
				<option value="positionCode" ${condition=="positionCode"?"selected='selected' ":""}>직책</option>
				<option value="idnCode" ${condition=="idnCode"?"selected='selected' ":""}>권한</option>
				<option value="adminName" ${condition=="adminName"?"selected='selected' ":""}>성명</option>
			</select>
			<input type="text" name="word" id="word" value="${word}"/>
			<button class="button" onclick="searchAdminList()">검색</button>
			</form>
		</div>
	</div>
	<div class="tbl_wrap">
		<table class="table tbl_hover td_bor_no">
			<colgroup>
				<col style="width:10%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th >번호</th>
					<th >관리자 아이디</th>
					<th >관리자명</th>
					<th >부서</th>
					<th >직책</th>
					<th >권한</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${listAdmin}">
				<tr>
					<td>${dto.listNum}</td>
					<td><a href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}">${dto.adminId}</a></td>
					<td><a href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}">${dto.adminName}</a></td>
					<td><a href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}">${dto.departName}</a></td>
					<td><a href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}">${dto.positionName}</a></td>
					<td><a href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}">${dto.identName}</a></td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>
<div class="t_center mt30">
	${paging}
</div>
</div>