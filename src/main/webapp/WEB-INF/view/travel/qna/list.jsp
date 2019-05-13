<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	function sendSearch() {
		var f = document.search_form;
		f.submit();
	}

	$(function(){
		$("body").on("click",".udline",function(){
			var listNum = $(this).closest("tr").attr("data-listNum");
			if($(".content"+listNum).hasClass("hide")){
				$(".content"+listNum).show();
				$(".content"+listNum).removeClass("hide");
				$(".content"+listNum).addClass("show");
			}else{
				$(".content"+listNum).hide();
				$(".content"+listNum).removeClass("show");
				$(".content"+listNum).addClass("hide");
			}
		});
		
		$("body").on("click",".btn-reply", function(){
			if($(this).parent().find("div").css("display")=="none"){
				$(this).parent().find("div").css("display","block");
			}else{
				$(this).parent().find("div").css("display","none");
			}
		});
		
		$("body").on("click",".btn-replyComplete", function(){
			if($(this).siblings("textarea").val().trim()==''){
				$(this).siblings("textarea").focus();
				return false;
			}
			var answerContent = $(this).siblings("textarea").val().trim();
			var url = "<%=cp%>/travel/admin/qna/insertAnswer";
			var qnaCode = $(this).closest("td").attr("data-qnaCode");
			$.ajax({
				type:"post",
				url:url,
				data:{
					answerContent:answerContent,
					qnaCode:qnaCode
				},
				success:function(data){
					location.href="<%=cp%>/travel/admin/qna/list";
					return false;
				},
				beforesend:function(e){
					e.setRequestHeader("AJAX",true);
				},
				error:function(e){
			    	if(e.status==403) {
			    		location.href="<%=cp%>/admin/login";
			    		return;
			    	}
				}
			});
		});
		
		
		$("body").on("click",".btn-replyDelete", function(){
			if(!confirm("삭제하시겠습니까?")){
				return false;
			}    
			var url = "<%=cp%>/travel/admin/qna/deleteAnswer";
			var answerCode = $(this).parent().attr("data-answerCode"); 
			$.ajax({
				type:"post", 
				url:url,
				data:{
					answerCode:answerCode
				},
				success:function(data){
					location.href="<%=cp%>/travel/admin/qna/list";
					return false;
				},
				beforesend:function(e){
					e.setRequestHeader("AJAX",true);
				},
				error:function(e){
			    	if(e.status==403) {
			    		location.href="<%=cp%>/admin/login";
			    		return;
			    	}
				}
				
			});
		});
	});
</script>
<style>
	.qnaFrame {
		text-align : left;
		margin:30px 60px;
		font-size: 16px;
	}
	
	.qnaFrame div {
		
		margin-bottom: 20px;
	}
	.qnaFrame div p,h3{
		margin-bottom: 10px;
	}
	.qnaFrame div p{
		padding-left: 40px;
	}
</style>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p><strong>문의사항</strong></p>
</div>

<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/travel/admin/qna/list'">새로고침</button>
	</div>
	<form name="search_form" action="<%=cp%>/travel/admin/qna/list" method="get">
		<div class="list_search"> 
			<select title="검색조건선택" name="searchKey">
				<option value="all" ${searchKey == 'all' ? "selected='selected'" : ""}>제목+내용</option>
           		<option value="subject" ${searchKey == 'subject' ? "selected='selected'" : ""}>제목</option>
           		<option value="content" ${searchKey == 'content' ? "selected='selected'" : ""}>내용</option>
           		<option value="userName" ${searchKey == 'userName' ? "selected='selected'" : ""}>작성자ID</option>
           		<option value="created" ${searchKey == 'created' ? "selected='selected'" : ""}>작성일</option>
			</select>
			<input type="text" title="검색내용입력" name="searchValue" value="${searchValue}" />
			<button type="button" class="button" onclick="sendSearch()">검색</button>
		</div>
	</form>
</div>

<table class="table tbl_hover">
	<caption>공지사항</caption>
	<colgroup>
		<col style="width:4%" />
		<col style="" />
		<col style="width:10%" />
		<col style="width:14%" />
		<col style="width:14%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
			<th scope="col">답변상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${list}">
			<tr data-listNum="${dto.listNum}">
				<td>${dto.listNum}</td>
				<td>
					<a class="udline" style="cursor: pointer;">
						<span>${dto.subject}</span>
					</a>
				</td>
				<td>${dto.userName}</td>
				<td>${dto.created}</td>
				<td>${empty dto.answers?'미답변':dto.answers.size()==1?'1차 답변':'2차 답변'}</td>
			</tr>
			<tr class="content${dto.listNum} hide" style="display: none; margin: 0;padding: 0;">
				<td style="margin: 0; padding:0;" colspan="5" data-qnaCode="${dto.qnaCode}">
				<div class="qnaFrame">
					<div>
						<h3>Q. ${dto.userName}님의 문의사항</h3>
						<p>${dto.content}</p>
					</div>
					<c:if test="${empty dto.answers}">
						<div style="text-align: center;"> 
								<h6>현재 답변이 없습니다.</h6>
								<button class="btn btn-black btn-reply" style="margin-bottom: 20px;">답변달기</button>
							<div style="display:none;">
								<textarea style="width: 80%;" placeholder="답변을 입력하세요"></textarea>
								<button style="height: 100px;" class="btn btn-black btn-replyComplete">답변 완료</button>
							</div>
						</div>
					</c:if>
					
					<c:if test="${not empty dto.answers}">
						<c:forEach var="answer" items="${dto.answers}">
							<div>
								<div style="width: 80%; float:left;">
									<h3 style="color: #1cc3b2">A.${answer.adminName}님의 답변</h3>
									<p>${answer.answerCreated}</p>
									<p>${answer.answerContent}</p>
								</div>
								<c:if test="${answer.adminIdx==sessionScope.admin.adminIdx}">
									<div style="width: 20%; float: left;" data-answerCode="${answer.answerCode}"> 
										<button class="btn btn-black btn-replyDelete">삭제</button>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</c:if>
				</div>
				</td>
			</tr>
		</c:forEach>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5">등록된 문의사항이 없습니다.</td>
				</tr>
			</c:if>
	</tbody>
</table>
<div class="t_center mt30">
	${paging}
</div>
<%-- <c:if test="${sessionScope.admin.departCode == 4 || sessionScope.admin.departCode == 3}">
	<div class="btn_wrap">
		<p class="f_right"><a href="<%=cp%>/travel/admin/qna/add" class="button h30 btn_brown w70">등록</a></p>
	</div>
</c:if> --%>