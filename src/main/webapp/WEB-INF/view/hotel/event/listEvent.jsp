<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>숙박 이벤트관리</strong></p>
</div>


    
   
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${eventCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right">
		          &nbsp;
		      </td>
		      <td align="center">
		        <form name="searchForm" action="<%=cp%>/hotel/event/listEvent" method="post">
				    <div class="list_search_wrap">
						<div class="list_search">
							<select name="searchKey" id="searchKey" title="검색조건선택">
								<option value="all">전체</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
				
							</select>
							<input type="text" name="searchValue" id="searchValue" title="검색내용입력" />
							
								<button class="button" onclick="searchList()">검색</button>
							
						</div>
					</div>
				</form>
		</td>
		   </tr>
		</table>
		
	<div class="tbl_wrap">
	<table class="table tbl_hover td_bor_no">
		<colgroup>
			<col style="width:10%" />
			<col style="width:50%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		  <tr> 
		      <th width="80">번호</th>
		      <th>제목</th>
		      <th>작성자</th>
		      <th width="150">작성일</th>
		      <th width="100">댓글수</th>
		      <th width="100">조회수</th>
		    
		  </tr>
		 </thead>
		 <tbody>
		 <c:forEach var="dto" items="${listEvent}">
		  <tr> 
		      <td>${dto.listNum}</td>
		      
		      <td>
		           <a href="${articleUrl}&eventNum=${dto.eventNum}">${dto.subject}</a>
		      </td>
		      <td>${dto.adminId}(${dto.adminName})</td>
		      <td>${dto.created}</td>
		      <td>${dto.replyCount}</td>
		      <td>${dto.hitCount}</td>
		  </tr>
		  </c:forEach>
		</tbody>
		</table>
		
	<div class="t_center mt30">
		${paging}
	</div>	
	
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/hotel/event/listEvent';">새로고침</button>
				</td>
		      
		              
		      <td align="right" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/hotel/event/insertEvent';">글올리기</button>
		      </td>
		   </tr>
		</table>
    

</div>