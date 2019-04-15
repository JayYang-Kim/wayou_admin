<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function updateAdmin(adminIdx){
<c:if test="${sessionScope.admin.idnCode == 2}">
	var url="<%=cp%>/admin/updateAdmin?adminIdx=${dto.adminIdx}&pageNum=${pageNum}";
	location.href=url;
</c:if>
<c:if test="${sessionScope.admin.idnCode != 2}">
	alert("게시글을 수정 할 수 없습니다.");
</c:if>
}

</script>
<h2>인사 관리 - ${dto.adminName}</h2>
<table class="table left_tbl">
	<caption>테이블 제목</caption>
	<colgroup>
		<col />
		<col style="width:15%"/>
		<col />
		<col style="width:15%"/>
		<col />
		<col style="width:15%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row" colspan="6" style="background:white"><b class="t_red">*</b> 기본정보</th>
		</tr>
		<tr>
			<td  rowspan="4" style="text-align:center; padding:0"><img src="<%=cp%>/uploads/admin/${dto.saveFilename}"></td>
		</tr>
		<tr>
			<th scope="row">아이디(ID)</th>
			<td >${dto.adminId}</td>
			<th scope="row">성명(Name)</th>
			<td >${dto.adminName}</td>
			<th>생년월일(Birth)</th>
		</tr>
		<tr>
			<th scope="row">이메일(Email)</th>
			<td colspan="1">${dto.email}</td>
			<th scope="row">전화번호(Tel)</th>
			<td >${dto.tel}</td>
			<td>${dto.adminBirth}</td>
		</tr>
		<tr>
			<th scope="row">주소(address)</th>
			<td colspan="4">${dto.postCode}&nbsp;${dto.address1}&nbsp;${dto.address2}&nbsp;${dto.etc}</td>
		</tr>
		<tr>
			<th scope="row" colspan="6" style="background:white"><b class="t_red">*</b> 근무정보</th>
		</tr>
		<tr>
			<th scope="row" colspan="2" style="text-align:center">부서</th>
			<th scope="row" colspan="2" style="text-align:center">직책</th>
			<th scope="row" colspan="2" style="text-align:center">권한</th>
		</tr>
		<tr>
			<td scope="row" colspan="2" style="text-align:center">${dto.departName}</td>
			<td scope="row" colspan="2" style="text-align:center">${dto.positionName}</td>
			<td scope="row" colspan="2" style="text-align:center">${dto.identName}</td>
		</tr>
		<tr>
			<th scope="row" style="text-align:center">내선번호(Ex-tel)</th>
			<td colspan="2">${dto.extNum}</td>
			<th scope="row">입사일(Date)</th>
			<td colspan="2">${dto.created}</td>
		</tr>
	</tbody>
</table>
		<div style="padding-top:10px; text-align:center;" >
			<button class="button btn_blk" onclick="updateAdmin('${adminIdx}')">수정</button>
			<button class="button btn_blk" onclick="javascript:location.href='<%=cp%>/admin/list';">돌아가기</button>
		</div>