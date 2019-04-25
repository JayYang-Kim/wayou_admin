<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(function(){
		$("select[name=tagCode]").val("${dto.tagCode}").attr("selected", "selected");
		$("select[name=locCode]").val("${dto.locCode}").attr("selected", "selected");
	});

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
		var url="<%=cp%>/travel/admin/landmark/deleteFile";
		$.post(url, {fileCode : fileCode}, function(data) {
			$("#f"+fileCode).remove();
		}, "json");
	}

	function postCode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	}
	
	function landMarkSend() {
		var f = document.landmark_form;
		var str;
		
		str = f.landName.value;
		str = str.trim();
		if(!str) {
			alert("랜드마크명을 선택해주세요.");
			f.landName.focus();
			return;
		}
		
		str = f.address1.value;
		str = str.trim();
		if(!str) {
			alert("주소를 입력해주세요.");
			f.address1.focus();
			return;
		}
		
		str = f.address2.value;
		str = str.trim();
		if(!str) {
			alert("상세주소를 입력해주세요.");
			f.address2.focus();
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
		
		var mode = "${mode}";
		
		if(mode == "add") {
			f.action = "<%=cp%>/travel/admin/landmark/${mode}";	
		} else if(mode == "update") {
			f.action = "<%=cp%>/travel/admin/landmark/${mode}${query}";
		}
		
		f.submit();
	}
</script>

<h1 id="page_tit">여행관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>여행관리</h2>
	<p>랜드마크 관리 &gt; <strong>등록</strong></p>
</div>

<form name="landmark_form" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
		<caption>랜드마크 등록</caption>
		<colgroup>
			<col style="width:20%"/>
			<col style="width:30%"/>
			<col style="width:20%"/>
			<col style="width:30%"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><b class="t_red">*</b> 지역</th>
				<td>
					<select class="width1" name="locCode" title="지역선택">
						<c:forEach var="dto_location" items="${listLocation}">
							<option value="${dto_location.locCode}">${dto_location.locName}</option>
						</c:forEach>
					</select>
				</td>
				<th scope="row"><b class="t_red">*</b> 랜드마크명</th>
				<td>
					<c:if test="${mode == 'update'}">
						<input type="hidden" name="landCode" value="${dto.landCode}"/>
					</c:if>
					<input type="text" class="width1" name="landName" title="랜드마크명" placeholder="랜드마크명" value="${dto.landName}" />
				</td>
			</tr>
			<tr>
				<th scope="row">태그명</th>
				<td colspan="3">
					<select class="width1" name="tagCode" title="태그선택">
						<c:forEach var="dto_tag" items="${listTag}">
							<option value="${dto_tag.tagCode}">${dto_tag.tagName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 주소</th>
				<td colspan="3">
					<input type="text" id="address" class="width1" name="address1" title="주소" placeholder="주소" value="${dto.address1}" />
					<input type="text" id="detailAddress" class="width1" name="address2" title="상세주소" placeholder="상세주소" value="${dto.address2}" />
					<button type="button" class="button btn_blk" onclick="postCode()">주소검색</button>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 위도</th>
				<td>
					<input type="text" class="width1" name="lat" title="위도" placeholder="위도 입력" value="${dto.lat}" />
				</td>
				<th scope="row"><b class="t_red">*</b> 경도</th>
				<td>
					<input type="text" class="width1" name="lng" title="경도" placeholder="경도 입력" value="${dto.lng}" />
				</td>
			</tr>
			<tr>
				<th scope="row">메모</th>
				<td colspan="3">
					<textarea name="memo" id="locationMemo" cols="30" rows="10">${dto.memo}</textarea>
				</td>
			</tr>
			<tr class="file_img">
				<th scope="row">이미지</th>
				<td colspan="3">
					<input type="file" class="w_100" name="upload" placeholder="파일첨부" title="파일첨부">
				</td>
			</tr>
			<c:if test="${mode == 'update'}">
				<c:forEach var="dto_landmarkFile" items="${listLandmarkFile}">
					<tr id="f${dto_landmarkFile.fileCode}" class="file_img">
						<th scope="row">이미지</th>
						<td colspan="3">
							${dto_landmarkFile.saveFilename}
							| <a href="javascript:deleteFile('${dto_landmarkFile.fileCode}');">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</form>
<div class="btn_wrap">
	<p class="f_right">
		<a href="<%=cp%>/travel/admin/landmark/list${query}" class="button h30 btn_wht w70">${mode == "add" ? "취소하기" : "수정취소"}</a>  
		<button type="button" class="button h30 btn_blk w70" onclick="landMarkSend()">${mode == "add" ? "등록하기" : "수정하기"}</button>
	</p>
</div>