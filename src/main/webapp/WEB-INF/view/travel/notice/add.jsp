<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
	$(function(){
		$("body").on("change", "input[name=upload]", function(){
  			if(! $(this).val()) {
  				return;	
  		  	}
  		
  		  	var b=false;
  		  	
  		  	$("input[name=upload]").each(function(){
  				if(! $(this).val()) {
  					b = true;
  			  		return;
  			  	}
  		  	});
  		
  		  	if(b) {
  				return;
  		  	}

  		 	var $tr, $th, $td, $input;
  		 	
			$tr=$("<tr>", {class:"file_img"});
			$th=$("<th>", {scope:"row", html:"이미지"});
			$tr.append($th);
  	      	$td=$("<td>", {colspan:"3"});
  	      	$input=$("<input>", {type:"file", name:"upload", class:"w_100", placeholder:"파일첨부", title:"파일첨부"});
  	      	$td.append($input);
  	      	$tr.append($td);
  	    
  	      	$(".table tbody").append($tr);
  	  	});
	});
	
	function deleteFile(fileCode) {
		var url="<%=cp%>/travel/admin/board/notice/deleteFile";
		$.post(url, {fileCode : fileCode}, function(data) {
			$("#f"+fileCode).remove();
		}, "json");
	}

	function noticeSend() {
		var f = document.notice_form;
		var str;
		
		str = f.subject.value;
		str = str.trim();
		if(!str) {
			alert("제목을 입력해주세요.");
			f.subject.focus();
			return;
		}
		
		str = f.content.value;
		str = str.trim();
		if(!str) {
			alert("내용을 입력해주세요.");
			f.content.focus();
			return;
		}
		
		var mode = "${mode}";
		
		if(mode == "add") {
			f.action = "<%=cp%>/travel/admin/board/notice/${mode}";	
		} else if(mode == "update") {
			f.action = "<%=cp%>/travel/admin/board/notice/${mode}${query}";
		}
		
		f.submit();
	}
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>공지사항 &gt; <strong>등록</strong></p>
</div>

<form name="notice_form" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
		<caption>공지사항 등록</caption>
		<colgroup>
			<col style="width:20%"/>
			<col style="width:30%"/>
			<col style="width:20%"/>
			<col style="width:30%"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><b class="t_red">*</b> 제목</th>
				<td colspan="3">
					<c:if test="${mode == 'update'}">
						<input type="hidden" name="notiCode" value="${dto.notiCode}"/>
					</c:if>
					<input type="text" class="width1 w_100" name="subject" title="제목" placeholder="제목을 입력해주세요." value="${dto.subject}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 내용</th>
				<td colspan="3">
					<textarea name="content" cols="30" rows="10" placeholder="내용을 입력해주세요.">${dto.content}</textarea>
				</td>
			</tr>
			<tr class="file_img">
				<th scope="row">이미지</th>
				<td colspan="3">
					<input type="file" class="w_100" name="upload" placeholder="파일첨부" title="파일첨부">
				</td>
			</tr>
			<c:if test="${mode == 'update'}">
				<c:forEach var="dto_boardFile" items="${listBoardFile}">
					<tr id="f${dto_boardFile.fileCode}" class="file_img">
						<th scope="row">이미지</th>
						<td colspan="3">
							${dto_boardFile.originalFilename}
							| <a href="javascript:deleteFile('${dto_boardFile.fileCode}');">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</form>
<div class="btn_wrap">
	<p class="f_right">
		<a href="<%=cp%>/travel/admin/board/notice/list${query}" class="button h30 btn_wht w70">${mode == "add" ? "취소하기" : "수정취소"}</a>  
		<button type="button" class="button h30 btn_blk w70" onclick="noticeSend()">${mode == "add" ? "등록하기" : "수정하기"}</button>
	</p>
</div>