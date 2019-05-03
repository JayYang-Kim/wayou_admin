<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<h1 id="page_tit">티켓관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>티켓관리</h2>
	<p><strong>티켓 등록ㆍ관리</strong></p>
</div>



<div>

	<div class="list_search_wrap">
		<div class="list_search">
			<select name="searchKey" id="searchKey" title="검색조건선택">
				<option value="storeName">스토어명</option>
				<option value="locTitle">지역</option>
				<option value="name">대표자명</option>
			</select>
			<input type="text" name="searchValue" id="searchValue" title="검색내용입력" />
			<span class="btn">
				<a class="button" onclick="searchList();" style="border: none;">검색</a>
			</span>
		</div>
	</div>
	<div class="store-body" style="width: 100%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="100">스토어명</th>
					<th width="50">지역</th>
					<th width="70">대표자명</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>
						<a href="<%=cp%>/store/storeInfo/view?storeCode=${dto.storeCode}">
							<span>${dto.storeName}</span>
						</a>
						</td>
						<td>${dto.locTitle}</td>
						<td>${dto.name}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
				${paging}
			</td>
		   </tr>
		</table>
	</div>

	<div class="btn_wrap view_btn">
		<button class="button btn_blk" type="button" onclick="location.href='<%=cp%>/store/storeInfo/insertStore';">새로운 스토어 등록</button>
	</div>


</div>
