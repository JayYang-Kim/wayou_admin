<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">

//문의사항 답변
$(function(){
	$(".faqArticle").hide();
	
	$(".faqSubject").on("click", function(){
		var tr = $(this).closest("tr").next(".faqArticle");
		var isHidden = $(this).closest("tr").next(".faqArticle").is(":hidden");
		var $this = $(this).closest("tr");
		if(isHidden) {
			var faqNum=$(this).attr("data-Num");
			$(".faqArticle").hide();
			tr.show();
		} else {
			tr.hide();
		}
	});
	
	
});
	
	//글수정
	$("body").on("click", ".btn_update", function(){
		var faqNum = $(this).attr("data-faqNum");
		
		var url="<%=cp%>/hotel/faq/update?faqNum=" + faqNum + "&page=${page}";
		location.href=url;
	});
	
	//글삭제
	$("body").on("click", ".btn_delete", function(){
		var qnaCode = $(this).attr("data-faqNum");
		
		if(confirm("게시물을 삭제하시겠습니까?")){
		
		var url="<%=cp%>/hotel/faq/delete?faqNum="+faqNum+"&page=${page}";
		location.href=url;
		}
	});
	


function searchList() {
	var f = document.searchForm;
	f.submit();
}
</script>


      
 
<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>자주하는질문</strong></p>
</div>

    
    <div>
		<table>
		   <tr height="35">
		      <td class="t_left">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td class="t_right" style="border-left: none;">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<table class="table" style="font-size: 15px;">
		  <tr align="center" bgcolor="#eeeeee" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
		      <th width="60" style="color: #787878;">번호</th>
		      <th style="color: #787878;">제목</th>
		      <th width="200" style="color: #787878;">작성자</th>
		  </tr>
<c:forEach var="dto" items="${list}">		 
		  <tr align="center" bgcolor="#ffffff" height="40" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.listNum}</td>
		      <td class="faqSubject" data-Num='${dto.faqNum}' style="cursor:pointer;">${dto.subject}</td>
		      <td>${dto.adminId}(${dto.adminName})</td>
		      
		  </tr>
		  <tr class="faqArticle" style="background-color: #F6F6F6">
		  	<td colspan="3" style="text-align: left !important;">
			  	<div style="margin:30px 10px 25px 40px;">
					<div style="margin-bottom: 30px;">
					<span style="display:inline-block; font-weight: bold;">Q.&nbsp;&nbsp;</span>${dto.subject}
					</div>
					<div align="right" style="margin-right: 30px;">
					<c:if  test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">
						<button type="button" class="btn_classic btn_update" data-faqNum='${dto.faqNum}' style="border-radius: 3px;" >수정</button>
					</c:if>
				
					
				<c:if test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">
					<button type="button" class="btn_classic btn_delete" style="border-radius: 3px;" data-faqNum='${dto.faqNum}'>삭제</button>
				</c:if>
					</div>
					<c:if test="${dto.content != 0}">
					<div>
					<span style="display:inline-block; font-weight: bold; color: #1cc3b2;">A.&nbsp;&nbsp;</span>${dto.content}
					</div>
					</c:if>
				</div>
		  	</td>
		  </tr>
</c:forEach>
		</table>
		 
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
			<td align="center" style="padding-top:10px;">
		        ${dataCount==0 ? "등록된 자료가 없습니다." : paging}
			</td>
		   </tr>
		</table>
		
		<div class="btn_wrap view_btn">
			<c:if test="${sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1'}">
				<button class="button btn" type="button" 
					onclick="location.href='<%=cp%>/hotel/faq/insertFaq?page=${page}';">글 등록</button>
			</c:if>
			</div>
    </div>

      

	

	
	