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
	});
	
	$("body").on("click", ".upd_confirm", function(){
		$(".btn_upd").hide();
		$(".btn_saveCancel").show();
		
		var select = "<select name='blackCount'>";
		select += "<option value='0'>유저</option>";
		select += "<option value='1'>블랙리스트</option>";
		select += "</select>";
		
		$('.box_blackCount').children(".area_confrim").html(select);
		
		$("select[name=blackCount]").val("${dto.blackCount}").attr("selected", "selected");
	});
	
	$("body").on("click", ".cancel_confirm", function(){
		$(".btn_upd").show();
		$(".btn_saveCancel").hide();
		
		$('.box_confirm').children(".area_confrim").html(msg);
		
		var blackCount = ${dto.blackCount};
		var msg = null;
		
		if(blackCount == 0) {
			msg = "유저";
		} else if(blackCount == 1) {
			msg = "블랙리스트";
		}
		
		$('.box_blackCount').children(".area_confrim").html(msg);
	});
	
	$("body").on("click", ".save_confirm", function(){
		var url = "<%=cp%>/travel/admin/black/updateBlackCount";
		var query = "userIdx=${dto.userIdx}&blackCount=" + $("select[name='blackCount']").val();
		
		$.ajax({
			type : "post",
			url : url,
			data : query,
			dataType : "JSON",
			success:function(data) {
				if(data.msg == "true") {
					var blackCount = data.blackCount;
					var msg = null;
					if(blackCount == 0) {
						msg = "유저";
					} else if(blackCount == 1) {
						msg = "블랙리스트";
					}
					
					$('.box_blackCount').children(".area_confrim").html(msg);
					$(".btn_saveCancel").hide();
					$(".btn_upd").show();
				} else {
					var title = $(".pop_wrap").find("h1"); 
					var content = $(".pop_wrap .pop_cont p:first-child");
					var btn = $(".pop_wrap .pop_cont p.t_center");
					
					title.html("블랙리스트");
					content.html("블랙리스트 수정 실패했습니다.");
					btn.remove();
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
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>블랙리스트 관리 &gt; <strong>상세정보</strong></p>
</div>

<table class="table left_tbl">
	<caption>고객 상세정보</caption>
	<colgroup>
		<col style="width:15%">
		<col>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">고객정보</th>
			<td>${dto.userId}(${dto.userName})</td>
			<th scope="row">등급</th>
			<td>${dto.roleCodeName}(${dto.roleCode})</td>
		</tr>
		<tr>
			<th scope="row">주소</th>
			<td colspan="3">(우편번호 : ${dto.postCode}) ${dto.userAddr1}, ${dto.userAddr2} (${dto.etc})</td>
		</tr>
		<tr>
			<th scope="row">전화번호</th>
			<td>${dto.userTel}</td>
			<th scope="row">이메일</th>
			<td>${dto.userEmail}</td>
		</tr>
		<tr>
			<th scope="row">블랙리스트</th>
			<td class="box_blackCount">
				<div class="inblock area_confrim">${dto.blackCount == 0 ? '유저' : '블랙리스트'}</div>
				<div class="inblock btn_upd">
					<button type="button" class="upd_confirm button btn_wht h35 ml10">수정</button>
				</div>
				<div class="inblock btn_saveCancel">
					<button type='button' class='save_confirm button btn_wht h35 ml10'>저장</button>
					<button type='button' class='cancel_confirm button btn_wht h35 ml5'>취소</button>
				</div>
			</td>
			<th scope="row">활성여부</th>
			<td>${dto.enabled == 1 ? '활성화' : '비활성'}</td>
		</tr>
		<tr>
			<th scope="row">생일</th>
			<td colspan="3">${dto.userBirth}</td>
		</tr>
		<tr>
			<th scope="row">가입일</th>
			<td>${dto.userCreated_date}</td>
			<th scope="row">수정일</th>
			<td>${dto.userModify_date}</td>
		</tr>
	</tbody>
</table>

<div class="tbl_btn">
	<p class="f_left">
		<c:if test="${not empty preReadUser}">
			<a href="<%=cp%>/travel/admin/black/view?${query}&userIdx=${preReadUser.userIdx}" class="button h30 w70 btn_wht">이전</a>
		</c:if>
		<c:if test="${not empty nextReadUser}">
			<a href="<%=cp%>/travel/admin/black/view?${query}&userIdx=${nextReadUser.userIdx}" class="button h30 w70 btn_wht">다음</a>
		</c:if>
	</p>
	<p class="f_right">
		<a href="<%=cp%>/travel/admin/black/list?${query}" class="button h30 w70 btn_blk">목록</a>
	</p>
</div>

<div class="mt20 mb20">
	<h3>이력현황</h3>
	<table class="table tbl_hover td_bor_no mt20">
		<caption>이력현황</caption>
		<colgroup>
			<col style=""/>
			<col style=""/>
			<col style=""/>
			<col style=""/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">블랙리스트</th>
				<th scope="col">고객정보</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty listBlackCountLog}">
				<c:forEach var="dto2" items="${listBlackCountLog}">
					<tr>
						<td>${dto2.blackCount == 0 ? '유저' : '블랙리스트'}</td>
						<td>${dto2.userId}(${dto2.userName})</td>
						<td>${dto2.adminId}(${dto2.adminName})</td>
						<td>${dto2.created}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty listBlackCountLog}">
				<tr>
					<td colspan="4">등록된 이력 리스트가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="tbl_btn">
		<p class="f_right">
			<a href="#" class="button h30 w70 btn_wht">전체 이력</a>
		</p>
	</div>
</div>