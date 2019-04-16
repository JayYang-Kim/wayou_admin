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
	location.href=url + "?adminIdx=${dto.adminIdx}&pageNum=${pageNum}";
}

var fn = 0;
function fire(){
	var fire=confirm("퇴직 처리하시겠습니까?");
	if(fire==true){
		$("#idnCode").val("0").prop("selected", true);
		$("#positionCode").val("0").prop("selected", true);
		$("#departCode").val("0").prop("selected", true);
		fn=1;
	}else if(fire==false){
		location.href="<%=cp%>/admin/articleAdmin?adminIdx=${dto.adminIdx}";
	}
}



function sabun(){
	var url="<%=cp%>/admin/sabun";
	$.ajax({
		type:"GET",
		url:url,
		success:function(data){
			var id=data.adminId;
			$("input[name=adminId]").val(id);
			$("input[name=adminPwd]").val("1234");
			
		},beforeSend:function(e){
			e.setRequestHeader("AJAX",true);
		},error:function(){
			if(e.status==403){
				location.href="<%=cp%>/admin/main";
				return;
			}
			console.log(e.responseText);
		}
	});
}

function bebun(adminIdx){
	var url="<%=cp%>/admin/bebun";
	var data="adminIdx="+adminIdx;
	$.ajax({
		type:"GET",
		url:url,
		data:data,
		success:function(data){
			var adminPwd=data.adminPwd;
			$("input[name=adminPwd]").val(adminPwd);
			
		},beforeSend:function(e){
			e.setRequestHeader("AJAX",true);
		},error:function(){
			if(e.status==403){
				location.href="<%=cp%>/admin/main";
				return;
			}
			console.log(e.responseText);
		}
	});
}
function created() {
    var mode="${mode}";
	var f = document.createdForm;
	var content;

	content = f.adminName.value;
    content = content.trim();
    if(!content) {
        alert("이름을 입력하세요. ");
        f.adminName.focus();
        return;
    }
    
    f.adminName.value = content;

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
    
    content=f.idnCode.value;
    content = content.trim();
    if(!content) {
        alert("권한을 선택해주세요. ");
        f.idnCode.focus();
        return;
    }

    content=f.positionCode.value;
    content = content.trim();
    if(!content) {
        alert("직책을 선택해주세요. ");
        f.positioncode.focus();
        return;
    }
    
    content=f.departCode.value;
    content = content.trim();
    if(!content) {
        alert("부서를 선택해주세요. ");
        f.departCode.focus();
        return;
    }
    
    if(mode=="created"){
    content=f.upload.value;
    content = content.trim();
    	if(!content) {
        alert("증명사진을 첨부해주세요. ");
        f.upload.focus();
        return;
    	}
    }
    if(mode=="created")
   		f.action = "<%=cp%>/admin/created";
	else
   		f.action = "<%=cp%>/admin/updateAdmin";

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


</script>
<div style="padding-left:10px; padding-bottom:15px;">
<h1>${mode=="created"?"| 인사 등록":"| 인사 수정"}</h1></div>
<div>
	<form name="createdForm" method="post" enctype="multipart/form-data">
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
						<c:if test="${mode=='created'}">
						<button type="button" onclick="sabun()" class="button btn_blk" style="width:80px;">생성</button>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 비밀번호 (Pass Word)</th>
				<td>
					<div class="inp_wid adminPwd">
						<input type="password" name="adminPwd"  style="width:150px;" readOnly ="readonly" value="${dto.adminPwd}" />
						<c:if test="${mode=='update'}">
						<button type="button" onclick="bebun('${dto.adminIdx}')" class="button btn_blk" style="width:80px;">초기화</button>
						</c:if>
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
				<th scope="row"><b class="t_red">*</b> 권한 (Authority)</th>
				<td>
					<div class="inp_wid idnCode">
						<select id="idnCode" name="idnCode">
							<option value="">선 택</option>
							<option value="0" ${dto.idnCode=="0" ? "selected='selected'" : ""}>0. 없음</option>
							<option value="1" ${dto.idnCode=="1" ? "selected='selected'" : ""}>1. 관리자</option>
							<option value="2" ${dto.idnCode=="2" ? "selected='selected'" : ""}>2. 총관리자</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 직책 (Position)</th>
				<td>
					<div class="inp_wid positionCode">
						<select id="positionCode" name="positionCode">
							<option value="">선 택</option>
							<option value="0" ${dto.positionCode=="0" ? "selected='selected'" : ""}>0. 퇴사</option>
							<option value="1" ${dto.positionCode=="1" ? "selected='selected'" : ""}>1. 사원</option>
							<option value="2" ${dto.positionCode=="2" ? "selected='selected'" : ""}>2. 대리</option>
							<option value="3" ${dto.positionCode=="3" ? "selected='selected'" : ""}>3. 과장</option>
							<option value="4" ${dto.positionCode=="4" ? "selected='selected'" : ""}>4. 사장</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 부서 (Department)</th>
				<td>
					<div class="inp_wid departCode">
						<select id="departCode" name="departCode">
							<option value="">선 택</option>
							<option value="0" ${dto.departCode=="0" ? "selected='selected'" : ""}>0. 없음</option>
							<option value="1" ${dto.departCode=="1" ? "selected='selected'" : ""}>1. 쇼핑</option>
							<option value="2" ${dto.departCode=="2" ? "selected='selected'" : ""}>2. 숙박</option>
							<option value="3" ${dto.departCode=="3" ? "selected='selected'" : ""}>3. 여행</option>
							<option value="4" ${dto.departCode=="4" ? "selected='selected'" : ""}>4. 관리</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> 증명사진 (Photo)</th>
				<td>
					<div class="inp_wid upload">
						 <input type="file" name="upload" size="53" style="width:250px;" value="${dto.saveFilename}">${dto.saveFilename}
					<c:if test="${mode=='update' }">
					<c:if test="${not empty dto.saveFilename}">
				         | <button type="button" onclick="deleteFile('${dto.saveFilename}')" class="button btn_blk" style="width:80px;">파일삭제</button>
				    </c:if>
				    </c:if>
					</div>
				</td>
			</tr>
	</table>
		<div style="margin-top:15px; text-align:center"><button type="button" onclick="created()" class="button btn_blk" style="width:80px;">${mode=="created"?"등록":"수정"}</button>
		<c:if test="${mode=='update' }">
		<button type="button" onclick="fire()" class="button btn_blk" style="width:100px;">퇴직 처리</button>
		</c:if>
		</div>
		<c:if test="${mode=='update'}">
		<input type="hidden" name="adminIdx" value="${dto.adminIdx}">
		</c:if>
	</form>
</div>
