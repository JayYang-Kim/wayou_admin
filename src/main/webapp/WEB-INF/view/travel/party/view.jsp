<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	$(function(){
		$(".btn_saveCancel").hide();
		
		$("body").on("click", ".upd_confirm", function(){
			$(".btn_upd").hide();
			$(".btn_saveCancel").show();
			
			var select = "<select name='chk_confirmCode'>";
			select += "<option value='0'>등록대기</option>";
			select += "<option value='1'>등록수락</option>";
			select += "<option value='2'>등록거절</option>";
			select += "</select>";
			
			$('.box_confirm').children(".area_confrim").html(select);
		});
		
		$("body").on("click", ".cancel_confirm", function(){
			$(".btn_upd").show();
			$(".btn_saveCancel").hide();
			
			$('.box_confirm').children(".area_confrim").html(msg);
			
			var cc = ${dto.confirmCode};
			var msg = null;
			
			if(cc == 0) {
				msg = "등록대기";
			} else if(cc == 1) {
				msg = "등록수락";
			} else {
				msg = "등록거절";
			}
			
			$('.box_confirm').children(".area_confrim").html(msg);
		});
		
		$("body").on("click", ".save_confirm", function(){
			var url = "<%=cp%>/travel/admin/party/updConfirm";
			var query = "partyCode=${dto.partyCode}&chk_confirmCode=" + $("select[name='chk_confirmCode']").val();
			
			$.ajax({
				type : "post",
				url : url,
				data : query,
				dataType : "JSON",
				success:function(data) {
					if(data.msg == "true") {
						var c = data.confirmCode;
						var msg = null;
						if(c == 0) {
							msg = "등록대기";
						} else if(c == 1) {
							msg = "등록수락";
						} else {
							msg = "등록거절";
						}
						
						$('.box_confirm').children(".area_confrim").html(msg);
						$(".btn_saveCancel").hide();
						$(".btn_upd").show();
					} else {
						alert("변경 실패했습니다.");
					}
				}
			    ,beforeSend:function(e) {
			    	e.setRequestHeader("AJAX", true);
			    }
			    ,error:function(e) {
			    	if(e.status==403) {
			    		location.href="<%=cp%>/admin/login";
			    		return;
			    	}
			    	console.log(e.responseText);
			    }
			});
		});
	});
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>여행동료 관리 &gt; <strong>상세정보</strong></p>
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
			<th scope="row">제목</th>
			<td colspan="3">${dto.subject}</td>
		</tr>
		<tr>
			<th scope="row">작성일</th>
			<td>${dto.created}</td>
			<th scope="row">작성자</th>
			<td>${dto.userName} (${dto.userId})</td>
		</tr>
		<tr>
			<th scope="row">시작일</th>
			<td>${dto.startDate}</td>
			<th scope="row">종료일</th>
			<td>${dto.endDate}</td>
		</tr>
		<tr>
			<th scope="row">활성여부</th>
			<td>${dto.enabled == 0 ? "활성" : "비활성"}</td>
			<th scope="row">확인여부</th>
			<td class="box_confirm">
				<div class="inblock area_confrim">${(dto.confirmCode == 0) ? '등록대기' : (dto.confirmCode == 1) ? '등록수락' : '등록거절'}</div>
				<div class="inblock btn_upd">
					<button type="button" class="upd_confirm button btn_wht h35 ml10">수정</button>
				</div>
				<div class="inblock btn_saveCancel">
					<button type='button' class='save_confirm button btn_wht h35 ml10'>저장</button>
					<button type='button' class='cancel_confirm button btn_wht h35 ml5'>취소</button>
				</div>
			</td>
		</tr>
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
<div class="mt20 mb20">
	<h3>참가현황 : ${dto.partyPeopleCount} / ${dto.max}</h3>
	<c:if test="${not empty joinPartyList}">
		<table class="table tbl_hover td_bor_no mt20">
			<caption>FAQ 정보</caption>
			<colgroup>
				<col style="width:10%">
				<col style="width:20%">
				<col style="width:20%">
				<col style="width:20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">유저정보</th>
					<th scope="col">상태</th>
					<th scope="col">참가내용</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto2" items="${joinPartyList}">
					<tr>
						<td>${dto2.userId}<br/>(${dto2.userName})</td>
						<td>${(dto2.pCode == 0) ? '대기자' : (dto2.pCode == 1) ? '참가수락' : (dto2.pCode == 2) ? '참거거절' : '파티탈퇴'}</td>
						<td>${dto2.memo }</td>
						<td>${dto2.created}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>
<div class="tbl_btn">
	<p class="f_left">
		<c:if test="${not empty preReadParty}">
			<a href="<%=cp%>/travel/admin/party/view?${query}&partyCode=${preReadParty.partyCode}" class="button h30 w70 btn_wht">이전</a>
		</c:if>
		<c:if test="${not empty nextReadParty}">
			<a href="<%=cp%>/travel/admin/party/view?${query}&partyCode=${nextReadParty.partyCode}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
	</p>
	<p class="f_right">
		<a href="<%=cp%>/travel/admin/party/list?${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>