<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table class="table tbl_view">
		<tr>
		    <th colspan='2'>
		       <div>
		           <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
		           <div style='float: right; text-align: right;'></div>
		       </div>
		    </th>
		</tr>

	
	
	<c:forEach var="vo" items="${listReply}">
	
	    <tr height='35'>
	       <td class="t_left">
	           <span><b>${vo.userName}</b></span>
	        </td>
	       <td class="t_right" style="border-left: none;">
	           <span>${vo.created}&nbsp;&nbsp;</span> 
	           <c:if test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">
	                <span class="deleteReply" style="cursor: pointer; color:red;" data-replyNum='${vo.replyNum}' data-pageNo='${pageNo}'>삭제하기</span>
	           	</c:if>
	        </td>
	    </tr>
	    <tr class="mb20">
	        <td colspan='2' valign='top' height='30' style='padding:10px 10px;'>
	              ${vo.content}
	        </td>
	    </tr>
	</c:forEach>
	
	

		<tr align="center">
            <td colspan='2' >
             	${paging}
            </td>
           </tr>

</table>
