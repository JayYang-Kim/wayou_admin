<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/hotel/event/listReply";
	var query="eventNum=${dto.eventNum}&pageNo="+page;
	
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			$("#listReply").html(data);
		}
	    ,beforeSend :function(jqXHR) {
	    	jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


</script>

<div>
    
    
    <div>
			<table class="table tbl_view">
			<colgroup>
				<col style="width:15%"/>
				<col />
				<col style="width:15%"/>
				<col />
			</colgroup>
			<tr>
			    <th colspan="4">
				   ${dto.subject}
			    </th>
			</tr>
			
			<tr>
			    <th>
			       	작성자 
			    </th>
			    <td>
			        ${dto.adminId}(${dto.adminName})  
			    </td>
			    <th>
			    	작성일 
			    </th>
			    <td>
			        ${dto.created}  
			    </td>
			</tr>
			<tr>
				<th>
					조회수 
				</th>
				<td>
					${dto.hitCount}
				</td>
				<th>
					좋아요 
				</th>
				<td>
					${dto.boardLikeCount} 개
				</td>
			</tr>
			<tr>
			  	<td colspan="2" height="500">
			      ${dto.content}
			    </td>
			</tr>
			
			
			
			
			
			<tr>
			    <td colspan="4">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/bbs/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr>
			    <td colspan="4">
			       다음글 :
			         <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/bbs/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table class="mb20">
			<tr height="45">
			    <td align="left">
			       <c:if test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">				    
			          <button type="button" class="btn" onclick="updateBoard();">수정</button>
				    
			          <button type="button" class="btn" onclick="deleteBoard();">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/hotel/event/listEvent?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
    <div>
		
		     
		<div id="listReply"></div>
    
    </div>
    
</div>
