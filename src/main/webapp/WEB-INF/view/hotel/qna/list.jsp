<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">

//문의사항 답변
$(function(){
	$(".qnaArticle").hide();
	
	$(".qnaSubject").on("click", function(){
		var tr = $(this).closest("tr").next(".qnaArticle");
		var isHidden = $(this).closest("tr").next(".qnaArticle").is(":hidden");
		var $this = $(this).closest("tr");
		if(isHidden) {
			var qnaCode=$(this).attr("data-Num");
			var url = "<%=cp%>/hotel/qna/hitCount";
			var query="qnaCode="+qnaCode;
			$.ajax({
				type:"post"
				,url:url
				,data:query
				,dataType:"JSON"
				,success:function(data) {
					if(data.msg=="true"){
						var hitCount = data.hitCount;
						$this.children("td:nth-child(6)").html(hitCount);
					}
				}
			    ,beforeSend:function(e) {
			    	e.setRequestHeader("AJAX", true);
			    }
			    ,error:function(e) {
			    	if(e.status==403) {
			    		location.href="<%=cp%>/member/login";
			    		return;
			    	}
			    	console.log(e.responseText);
			    }
			});
			$(".qnaArticle").hide();
			tr.show();
		} else {
			tr.hide();
		}
	});
	
	//글수정
	$("body").on("click", ".btn_update", function(){
		var qnaCode = $(this).attr("data-qnaCode");
		
		var url="<%=cp%>/hotel/qna/update?qnaCode=" + qnaCode + "&page=${page}";
		location.href=url;
	});
	
	//글삭제
	$("body").on("click", ".btn_delete", function(){
		var qnaCode = $(this).attr("data-qnaCode");
		
		if(confirm("게시물을 삭제하시겠습니까?")){
		
		var url="<%=cp%>/ticket/qna/delete?qnaCode="+qnaCode+"&page=${page}";
		location.href=url;
		}
	});
	
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
	<p><strong>문의사항</strong></p>
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
		      <th width="100" style="color: #787878;">답변상태</th>
		      <th style="color: #787878;">제목</th>
		      <th width="100" style="color: #787878;">작성자</th>
		      <th width="120" style="color: #787878;">작성일</th>
		      <th width="60" style="color: #787878;">조회수</th>
		      
		  </tr>
<c:forEach var="dto" items="${list}">		 
		  <tr align="center" bgcolor="#ffffff" height="40" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.listNum}</td>
		      <c:if test="${dto.answerCount == 0 }">
		      <td class="t_red">
		      	답변미완료
		      </td>
		      </c:if>
		      <c:if test="${dto.answerCount != 0 }">
		      <td style="color: #1cc3b2;">
		      	답변완료
		      </td>
		      </c:if>
		      
		      <%-- <td>
		      	${dto.answerCount == 0 ? '검토중' : '답변완료'}
		      </td> --%>
		      <td class="qnaSubject" data-Num='${dto.qnaCode}' style="cursor:pointer;">${dto.subject}</td>
		      <td>${dto.userName}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		  </tr>
		  <tr class="qnaArticle" style="background-color: #F6F6F6">
		  	<td colspan="6" style="text-align: left !important;">
			  	<div style="margin:30px 10px 25px 40px;">
					<div style="margin-bottom: 30px;">
					<span style="display:inline-block; font-weight: bold;">Q.&nbsp;&nbsp;</span>${dto.content}
					</div>
					<div align="right" style="margin-right: 30px;">
					<c:if  test="${dto.answerCount == 0 && (sessionScope.admin.idnCode == '2' || sessionScope.admin.adminId == 'sug1')}">
						<button type="button" class="btn_classic btn_answer" style="border-radius: 3px;" onclick="javascript:location.href='<%=cp%>/hotel/qna/insertAnswer?qnaCode=${dto.qnaCode}&page=${page}&catCode=${dto.catCode}';">답변 등록하기</button>
					</c:if>
				
					<!-- 삭제 - admin 권한추가해야함 -->
				<c:if test="">
					<button type="button" class="btn_classic btn_delete" style="border-radius: 3px;" data-qnaCode='${dto.qnaCode}'>삭제</button>
				</c:if>
					</div>
					<c:if test="${dto.answerCount != 0}">
					<div>
					<span style="display:inline-block; font-weight: bold; color: #1cc3b2;">A.&nbsp;&nbsp;</span>${dto.answerContent}
					<p style="color: #1cc3b2; font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${dto.answerCreated}</p>
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
		
		<table style="width: 100%; margin: 30px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="btn_classic" style="font-size: 15px; height: 30px; border-radius: 5px;" onclick="javascript:location.href='<%=cp%>/hotel/qna/list?catCode=2';">새로고침</button>
		      </td>
      		<td align="center">
	          <form name="searchForm" action="<%=cp%>/ticket/qna/list" method="post">
		              <select name="searchKey" class="select">
		                  <option value="all" ${searchKey=="all" ? "selected='selected' " : "" }>모두</option>
		                  <option value="subject"  ${searchKey=="subject" ? "selected='selected' " : "" }>제목</option>
		                  <option value="userName" ${searchKey=="userName" ? "selected='selected' " : "" }>작성자</option>
		                  <option value="content"  ${searchKey=="content" ? "selected='selected' " : "" }>내용</option>
		                  <option value="created"  ${searchKey=="created" ? "selected='selected' " : "" }>등록일</option>
		            </select>
		            <input type="text" name="searchValue" class="form-control t_center" style="width:200px; height: 30px;" value="${searchValue}">
		            <button type="button" class="btn-black t_center" style="width: 50px; height: 35px; border-radius: 5px;" onclick="searchList()">검색</button>
		        </form>
		      </td>
		      
		   </tr>
		</table>
    </div>

      

	

	
	