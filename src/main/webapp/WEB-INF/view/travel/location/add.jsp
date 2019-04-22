<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	function locationSend() {
		var f = document.location_form;
		var str;

		str = f.locCode.value;
		str = str.trim();
		if(!str) {
			alert("지역을 선택해주세요.");
			f.locCode.focus();
			return;
		}
	    
		str = f.lat.value;
		str = str.trim();
	    if(!str) {
	        alert("위도를 입력해주세요.");
	        f.lat.focus();
	        return;
	    }
	    if(!/^[-]?\d+(?:[.]\d+)?$/.test(str)) {
	        alert("입력 불가능한 값이있습니다.");
	        f.lat.focus();
	        return;
	    }
	    
	    str = f.lng.value;
		str = str.trim();
	    if(!str) {
	        alert("경도를 입력해주세요.");
	        f.lng.focus();
	        return;
	    }
	    
	    if(!/^[-]?\d+(?:[.]\d+)?$/.test(str)) {
	        alert("입력 불가능한 값이있습니다.");
	        f.lng.focus();
	        return;
	    }
	    
	    str = f.enable.value;
		str = str.trim();
		if(!str) {
			alert("활성여부를 선택해주세요.");
			f.enable.focus();
			return;
		}
		
		f.action = "<%=cp%>/travel/admin/location/${mode}";
		f.submit();
	}
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>지역 관리 &gt; <strong>등록</strong></p>
</div>

<form name="location_form" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
		<caption>지역 등록</caption>
		<colgroup>
			<col style="width:20%"/>
			<col style="width:30%"/>
			<col style="width:20%"/>
			<col style="width:30%"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><b class="t_red">*</b> 지역</th>
				<td colspan="3">
					<select class="width1" name="locCode" title="지역선택">
						<c:forEach var="dto_loc" items="${listLoc}">
							<option value="${dto_loc.locCode}">${dto_loc.locName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 위도</th>
				<td>
					<input type="text" class="width1" name="lat" title="위도" placeholder="위도 입력" />
				</td>
				<th scope="row"><b class="t_red">*</b> 경도</th>
				<td>
					<input type="text" class="width1" name="lng" title="경도" placeholder="경도 입력" />
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 활성여부</th>
				<td colspan="3">
					<label class="radio">
						<input name="enable" type="radio" value="1" checked="checked">
						<span class="lbl">활성화</span>
					</label>
					<label class="radio ml10">
						<input name="enable" type="radio" value="0">
						<span class="lbl">비활성</span>
					</label>
				</td>
			</tr>
			<tr>
				<th scope="row">이미지</th>
				<td colspan="3">
					<input type="file" class="w_100" name="upload" placeholder="파일첨부" title="파일첨부">
				</td>
			</tr>
			<tr>
				<th scope="row">메모</th>
				<td colspan="3">
					<textarea name="memo" id="locationMemo" cols="30" rows="10"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="btn_wrap">
	<p class="f_right">
		<c:if test="${mode == 'update'}">
			
		</c:if>
		<a href="<%=cp%>/travel/admin/location/list" class="button h30 btn_wht w70">${mode == "add" ? "취소하기" : "수정취소"}</a>  
		<button type="button" class="button h30 btn_blk w70" onclick="locationSend()">${mode == "add" ? "등록하기" : "수정하기"}</button>
	</p>
</div>