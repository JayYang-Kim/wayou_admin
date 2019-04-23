<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	$("body").on("click", ".btn_update", function(){
		var title = $(".pop_wrap").find("h1"); 
		var content = $(".pop_wrap .pop_cont p:first-child");
		var link = $(".pop_wrap .pop_cont p.t_center a.btn_blk");
		var linkUrl = "<%=cp%>/travel/admin/location/update${query}&locCode=${dto.locCode}";
		
		title.html("지역 수정");
		content.html("지역 정보를 수정하시겠습니까?");
		link.attr("href", linkUrl);
	});
	
	$("body").on("click", ".btn_delete", function(){
		var title = $(".pop_wrap").find("h1"); 
		var content = $(".pop_wrap .pop_cont p:first-child");
		var link = $(".pop_wrap .pop_cont p.t_center a.btn_blk");
		var linkUrl = "<%=cp%>/travel/admin/location/delete${query}&locCode=${dto.locCode}";
		
		title.html("지역 삭제");
		content.html("지역 정보를 삭제하시겠습니까?");
		
		link.attr("href", linkUrl);
	});
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>지역 관리 &gt; <strong>상세정보</strong></p>
</div>

<table class="table left_tbl">
	<caption>여행동료 상세정보</caption>
	<colgroup>
		<col style="width:15%">
		<col>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">지역정보</th>
			<td>${dto.locName}(${dto.locCode})</td>
			<th scope="row">활성여부</th>
			<td>${dto.enable == 1 ? '활성화' : '비활성'}</td>
		</tr>
		<tr>
			<th scope="row">위도</th>
			<td>${dto.lat}</td>
			<th scope="row">경도</th>
			<td>${dto.lng}</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${dto.adminId}(${dto.adminName})</td>
			<th scope="row">작성일</th>
			<td>${dto.created}</td>
		</tr>
		<tr>
			<th scope="row">이미지</th>
			<td colspan="3"><a href="<%=cp%>/travel/admin/location/download?locCode=${dto.locCode}">${dto.originalFilename}</a></td>
		</tr>
		<tr>
			<th scope="row">메모</th>
			<td colspan="3">
				<div class="view_cont">
					${dto.memo}
				</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="tbl_btn">
	<p class="f_left">
		<c:if test="${not empty preReadLocation}">
			<a href="<%=cp%>/travel/admin/location/view${query}&locCode=${preReadLocation.locCode}" class="button h30 w70 btn_wht">이전</a>
		</c:if>
		<c:if test="${not empty nextReadLocation}">
			<a href="<%=cp%>/travel/admin/location/view${query}&locCode=${nextReadLocation.locCode}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
	</p>
	<p class="f_right">
		<button type="button" class="btn_update button h30 w70 btn_wht" onclick="layerShow('#popup')">수정</button>
		<button type="button" class="btn_delete button h30 w70 btn_red" onclick="layerShow('#popup')">삭제</button>
		<%-- <a href="<%=cp%>/travel/admin/location/update${query}&locCode=${dto.locCode}" class="button h30 w70 btn_wht">수정</a>
		<a href="<%=cp%>/travel/admin/location/delete${query}&locCode=${dto.locCode}" class="button h30 w70 btn_red">삭제</a> --%>
		<a href="<%=cp%>/travel/admin/location/list${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>

<div class="mt20 mb20">
	<h3>이력현황</h3>
	<table class="table tbl_hover td_bor_no mt20">
		<caption>이력현황</caption>
		<colgroup>
			<col style="width:10%" span="2"/>
			<col style=""/>
			<col style="width:10%"/>
			<col style="width:10%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">위도</th>
				<th scope="col">경도</th>
				<th scope="col">메모</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty listLocationLog}">
				<c:forEach var="dto2" items="${listLocationLog}">
					<tr>
						<td>${dto2.lat}</td>
						<td>${dto2.lng}</td>
						<td>${dto2.memo}</td>
						<td>${dto2.adminId}<br/>(${dto2.adminName})</td>						
						<td>${dto2.created}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty listLocationLog}">
				<tr>
					<td colspan="5">등록된 이력 리스트가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="tbl_btn">
		<p class="f_right">
			<a href="#" class="button h30 w70 btn_wht">전체 이력</a>
		</p>
	</div>
</div>