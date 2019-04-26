<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
var ra="${state}";
if(ra!=""){ 
	alert(ra);
}

function deleteFile(){
	var url="<%=cp%>/admin/deleteFile";
	location.href=url + "?adminIdx=${dto.adminIdx}&page=${page}";
}

function update() {
	var f = document.updateForm;
	var content;

	content = f.adminPwd.value;
    content = content.trim();
		if(!content) {
				alert("패스워드를 입력하세요. ");
				f.adminPwd.focus();
				return;
			}
		if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(content)) { 
				alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
				f.adminPwd.focus();
				return;
			}

		if(content!= f.adminPwdCheck.value) {
	        	alert("패스워드가 일치하지 않습니다. ");
	        	f.adminPwdCheck.focus();
	        	return;
			}
	
	content = f.adminName.value;
    content = content.trim();
	    if(!content) {
	        alert("이름을 입력하세요. ");
	        f.adminName.focus();
	        return;
	    }
	    
	content = f.postCode.value;
	content = content.trim();
	    if(!content) {
	        alert("우편 번호를 입력하세요. ");
	        f.postCode.focus();
	        return;
	    }
	content = f.address1.value;
	content = content.trim();
	    if(!content) {
	        alert("도로명 주소를 입력하세요. ");
	        f.address1.focus();
	        return;
	    }
	content = f.address2.value;
	content = content.trim();
	    if(!content) {
	        alert("지번 주소를 입력하세요. ");
	        f.address2.focus();
	        return;
	    }
	content = f.etc.value;
	content = content.trim();
	    if(!content) {
	        alert("상세 주소를 입력하세요. ");
	        f.etc.focus();
	        return;
	    }
	    
	content = f.adminBirth.value;
    content = content.trim();
	    if(!content || !isValidDateFormat(content)) {
	        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
	        f.adminBirth.focus();
	        return;
	    }
    
    content = f.email1.value;
    content = content.trim();
	    if(!content) {
	        alert("이메일을 입력하세요. ");
	        f.email1.focus();
	        return;
	    }

    content = f.email2.value;
    content = content.trim();
	    if(!content) {
	        alert("이메일을 입력하세요. ");
	        f.email2.focus();
	        return;
	    }
    
    content = f.tel1.value;
    content = content.trim();
	    if(!content) {
	        alert("전화번호를 입력하세요. ");
	        f.tel1.focus();
	        return;
	    }

    content = f.tel2.value;
    content = content.trim();
	    if(!content) {
	        alert("전화번호를 입력하세요. ");
	        f.tel2.focus();
	        return;
	    }
	    if(!/^(\d+)$/.test(content)) {
	        alert("숫자만 가능합니다. ");
	        f.tel2.focus();
	        return;
	    }

    content = f.tel3.value;
    content = content.trim();
	    if(!content) {
	        alert("전화번호를 입력하세요. ");
	        f.tel3.focus();
	        return;
	    }
	    if(!/^(\d+)$/.test(content)) {
	        alert("숫자만 가능합니다. ");
	        f.tel3.focus();
	        return;
	    }
    
    content=f.upload.value;
    content = content.trim();
    	if(!content) {
        alert("증명사진을 첨부해주세요. ");
        f.upload.focus();
        return;
    	}

    	
     content = f.exTel1.value;
     content = content.trim();
 	    if(!content) {
 	        alert("내선 전화번호를 입력하세요. ");
 	        f.exTel1.focus();
 	        return;
 	    }
 	    if(!/^(\d+)$/.test(content)) {
 	        alert("숫자만 가능합니다. ");
 	        f.exTel1.focus();
 	        return;
 	    }
 	    
      content = f.exTel2.value;
      content = content.trim();
   	    if(!content) {
   	        alert("내선 전화번호를 입력하세요. ");
   	        f.exTel2.focus();
   	        return;
   	    }
   	    if(!/^(\d+)$/.test(content)) {
   	        alert("숫자만 가능합니다. ");
   	        f.exTel2.focus();
   	        return;
   	    }
   	    
      content = f.exTel3.value;
      content = content.trim();
   	    if(!content) {
   	        alert("내선 전화번호를 입력하세요. ");
   	        f.exTel3.focus();
   	        return;
   	    }
   	    if(!/^(\d+)$/.test(content)) {
   	        alert("숫자만 가능합니다. ");
   	        f.exTel3.focus();
   	        return;
   	    }
   	    
   	f.action = "<%=cp%>/admin/myupdate";

    f.submit();
}

function selectedEmail() {
    var f = document.createdForm;
	    
    var content = f.selectEmail.value;
    if(content!="write") {
        f.email2.value=content; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function myForm_Postcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            var roadAddr = data.roadAddress; 
            var extraRoadAddr = ''; 

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('postCode').value = data.zonecode;
            document.getElementById("address1").value = roadAddr;
            document.getElementById("address2").value = data.jibunAddress;

        }
    }).open();
}
</script>
<h1 id="page_tit">직원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>인사관리</h2>
	<p><strong>내정보 수정</strong></p>
</div>
<div>
	<form name="updateForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
		<colgroup>
			<col style="width:15%" />
			<col />
		</colgroup>			
			<tr>
				<th scope="row"><b class="t_red">*</b> 아이디 (ID)</th>
				<td>
					<div class="inp_wid adminId">
						<input type="text" name="adminId"  style="width:150px;" readOnly ="readonly" value="${dto.adminId}">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 비밀번호 (Pass Word)</th>
				<td>
					<div class="inp_wid adminPwd">
						<input type="password" name="adminPwd"  style="width:150px;" />
					</div>
			<tr>
				<th scope="row"><b class="t_red">*</b> 비밀번호 확인 (Pass Word)</th>
					<td>
					<div class="inp_wid adminPwdCheck">
						<input type="password" name="adminPwdCheck"  style="width:150px;"  />
					</div>
					</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 성명 (Name)</th>
				<td>
					<div class="inp_wid adminName">
						<input type="text" placeholder="성명"  name="adminName" value="${dto.adminName}"/>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 생년월일 (Birth)</th>
				<td>
					<div class="inp_wid Birth">
						<input type="text" placeholder="YYYY-MM-DD 형식" name="adminBirth" style="width:150px;" value="${dto.adminBirth }"/>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 이메일 (E-mail)</th>
				<td>
					<div class="inp_wid selectEmail">
						<select name="selectEmail" onchange="selectedEmail();">
							<option value="">선택</option>
							<option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="write">직접입력</option>
						</select>
							<input type="text" placeholder="E-mail ID" name="email1" value="${dto.email1}">
							<span style="font-weight:bold;">&nbsp;@</span>
							<input type="text" name="email2" value="${dto.email2}">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 전화번호 (Tel)</th>
				<td>
					<div class="inp_wid selectTel">
						<select name="tel1" id="tel1">
			                <option value="">선 택</option>
			                <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
			                <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
			                <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
			                <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
			                <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
			                <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
						</select>
							<span style="font-size:18px; font-weight:bold;">&nbsp;-</span>
							<input type="text" name="tel2" value="${dto.tel2}"/>
							<span style="font-size:18px; font-weight:bold;">&nbsp;-</span>
							<input type="text" name="tel3" value="${dto.tel3}" />
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 내선번호 (Ex-Tel)</th>
				<td>
					<div class="inp_wid ex-Tel">
							<input type="text" id="exTel1" name="exTel1" value="${dto.exTel1}"/>
							<span style="font-size:18px; font-weight:bold;">&nbsp;-</span>
							<input type="text" id="exTel2" name="exTel2" value="${dto.exTel2}"/>
							<span style="font-size:18px; font-weight:bold;">&nbsp;-</span>
							<input type="text" id="exTel3" name="exTel3" value="${dto.exTel3}" />
					</div>
				</td>
			</tr>
			<tr>
			<th scope="row"><b class="t_red">*</b> 주소 (Address)</th>
	 		<td>
	 			<div style="margin-bottom:10px">
		 		<input type="text" id="postCode" placeholder="우편번호" value="${dto.postCode}">
				<button type="button" onclick="myForm_Postcode()" class="btn_classic" style="width:100px;">주소 검색</button><br>
				</div>
				<input type="text" id="address1" name="address1" value="${dto.address1}" placeholder="도로명 주소">
				<input type="text" id="address2" name="address2" value="${dto.address2}" placeholder="지번주소">
				<input type="text" id="etc" name="etc" value="${dto.etc}" placeholder="상세주소">
			</td>
	 	</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 권한 (Authority)</th>
				<td>${dto.identName}</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 직책 (Position)</th>
				<td>${dto.positionName}</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 부서 (Department)</th>
				<td>${dto.departName}</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 증명사진 (Photo)</th>
				<td>
					<div class="inp_wid upload">
						 <input type="file" name="upload" size="53" style="width:250px;" value="${dto.saveFilename}">${dto.saveFilename}
					<c:if test="${not empty dto.saveFilename}">
				         | <button type="button" onclick="deleteFile('${dto.saveFilename}')" class="button btn_blk" style="width:80px;">파일삭제</button>
				    </c:if>
					<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
					</div>
				</td>
			</tr>
	</table>
		<div style="margin-top:15px; text-align:center"><button type="button" onclick="update()" class="button btn_blk" style="width:80px;">수정</button>
		</div>
		<input type="hidden" name="adminIdx" value="${dto.adminIdx}">
	</form>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>