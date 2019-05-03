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
		var linkUrl = "<%=cp%>/travel/admin/board/event/update${query}&eventCode=${dto.eventCode}";
		
		title.html("이벤트 수정");
		content.html("이벤트 정보를 수정하시겠습니까?");
		link.attr("href", linkUrl);
	});
	
	$("body").on("click", ".btn_delete", function(){
		var title = $(".pop_wrap").find("h1"); 
		var content = $(".pop_wrap .pop_cont p:first-child");
		var link = $(".pop_wrap .pop_cont p.t_center a.btn_blk");
		var linkUrl = "<%=cp%>/travel/admin/board/event/delete${query}&eventCode=${dto.eventCode}";
		
		title.html("이벤트 삭제");
		content.html("이벤트 정보를 삭제하시겠습니까?");
		
		link.attr("href", linkUrl);
	});
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>이벤트 &gt; <strong>상세정보</strong></p>
</div>

<table class="table left_tbl">
	<caption>이벤트 상세정보</caption>
	<colgroup>
		<col style="width:15%">
		<col>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3">${dto.subject}</td>
		</tr>
		<tr>
			<th scope="row">시작일</th>
			<td>${dto.startDate}</td>
			<th scope="row">종료일</th>
			<td>${dto.endDate}</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${dto.adminId}(${dto.adminName})</td>
			<th scope="row">작성일</th>
			<td>${dto.created}</td>
		</tr>
		<c:if test="${not empty listBoardFile}">
			<c:forEach var="dto_boardFile" items="${listBoardFile}">
				<tr>
					<th scope="row">이미지</th>
					<td colspan="3">${dto_boardFile.saveFilename}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listBoardFile}">
			<tr>
				<th scope="row">이미지</th>
				<td colspan="3"></td>
			</tr>
		</c:if>
		<tr>
			<th scope="row">내용</th>
			<td colspan="3">
				<div class="view_cont">
					${dto.content}
				</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="tbl_btn">
	<p class="f_left">
		<c:if test="${not empty preReadBoard}">
			<a href="<%=cp%>/travel/admin/board/event/view${query}&eventCode=${preReadBoard.eventCode}" class="button h30 w70 btn_wht">이전</a>
		</c:if>
		<c:if test="${not empty nextReadBoard}">
			<a href="<%=cp%>/travel/admin/board/event/view${query}&eventCode=${nextReadBoard.eventCode}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
	</p>
	<p class="f_right">
		<c:if test="${sessionScope.admin.departCode == 4 || sessionScope.admin.departCode == 3}">
			<button type="button" class="btn_update button h30 w70 btn_wht" onclick="layerShow('#popup')">수정</button>
			<button type="button" class="btn_delete button h30 w70 btn_red" onclick="layerShow('#popup')">삭제</button>
		</c:if>
		<a href="<%=cp%>/travel/admin/board/event/list${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>