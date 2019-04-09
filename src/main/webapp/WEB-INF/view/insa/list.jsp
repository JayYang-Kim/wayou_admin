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
</script>
<h2>인사 리스트</h2>

<div>
	<div class="list_search_wrap">
		<div class="list_search">
			<select name="condition" id="condition">
				<option value="departCode" ${condition=="departCode"?"selected='selected' ":""}>부서</option>
				<option value="positionCode" ${condition=="positionCode"?"selected='selected' ":""}>직책</option>
				<option value="adminName" ${condition=="adminName"?"selected='selected' ":""}>성명</option>
			</select>
			<input type="text" name="word" id="word" value="${word}"/>
			<button class="button" onclick="searchAdminList()">검색</button>
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
					<td>${dto.adminId}</td>
					<td>${dto.adminName}</td>
					<td>${dto.departName}</td>
					<td>${dto.positionName}</td>
					<td>${dto.identName}</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>
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
</div>