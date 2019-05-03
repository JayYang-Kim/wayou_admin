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
				  b=true;
			  	  return;
			  }
		  });
		
		  if(b) return;

		  var $tr, $td, $th, $input;
		
	      $tr=$("<tr>");
	      $th=$("<th>", {style:"border-top:none"});
	      $tr.append($th);
	      $th=$("</th>");
	      $tr.append($th);
	      $td=$("<td>");
	      $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"height: 25px;"});
	      $td.append($input);
	      $tr.append($td);
	    
	      $("#tb").append($tr);
	  });
});


function sendStore(mode) {
    var f = document.insertStoreForm;
	/* 	
	if(! f.hname.value) {
		alert("호텔명을 입력하세요.");
		f.hname.focus();
		return;
	}
	
	if(! f.address1.value) {
		f.address1.focus();
		return;
	}
	
	if(! f.address2.value) {
		f.address2.focus();
		return;
	}
	
	if(! f.email.value) {
		f.email.focus();
		return;
	}
	
	if(! f.tel.value) {
		f.tel.focus();
		return;
	}
  */
	if(mode=="created") {
		f.action="<%=cp%>/store/storeInfo/insertStore";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/hotelInfo/roomInfo/updateRoom";
	}
 
	
    f.submit();

}


function store_Postcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

           
            if (data.userSelectedType === 'R') { 
                addr = data.roadAddress;
            } else { 
                addr = data.jibunAddress;
            }


            if(data.userSelectedType === 'R'){
               
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
        
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
              
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
           
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

   
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address1").value = addr;
     
            document.getElementById("address2").focus();
        }
    }).open();
}
</script>

<div>
  <form name="insertStoreForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
	<tbody id="tb">
	 	<tr>
	 		<th >스토어명</th>
	 		<td><input type="text" name="storeName" value="${dto.storeName}"></td>
	 	</tr>
	 	<tr>
	 		<th>지역</th>
	 		<td>
	 			<select id="locCode" name="locCode">
	 				<option value="1" ${dto.locCode=="1"?"selected='selected'":""}>서울</option>
    				<option value="2" ${dto.locCode=="2"?"selected='selected'":""}>부산</option>
    				<option value="3" ${dto.locCode=="3"?"selected='selected'":""}>제주도</option>
	 			</select>
	 		</td>
	 	</tr>
	 	<tr>
	 		<th>지역 타이틀</th>
	 		<td><input type="text" name="locTitle" value="${dto.locTitle}"></td>
	 	</tr>
	 	<tr>
	 		<th>카테고리</th>
	 		<td>
	 			<select id="locCode" name=categoryCode>
	 				<option value="1" ${dto.categoryCode=="1"?"selected='selected'":""}>테마파크</option>
    				<option value="2" ${dto.categoryCode=="2"?"selected='selected'":""}>워터파크</option>
    				<option value="3" ${dto.categoryCode=="3"?"selected='selected'":""}>익스트림</option>
	 			</select>
	 		</td>
	 	</tr>
	 	<tr>
	 		<th>주소</th>
	 		<td>
		 		<input type="text" id="postcode" name="postcode" placeholder="우편번호" value="${dto.postcode}">
				<input type="button" onclick="store_Postcode()" value="우편번호 찾기"><br>
				<input type="text" id="address1" name="address1" value="${dto.address1}" placeholder="주소"><br>
				<input type="text" id="address2" name="address2" value="${dto.address2}" placeholder="상세주소">
				<input type="text" id="extraAddress"  placeholder="참고항목">
			</td>
	 	</tr>
	 	<tr>
	 		<th>이메일</th>
	 		<td><input type="text" name="email" value="${dto.email}"></td>
	 	</tr>
	 	<tr>
	 		<th>전화번호</th>
	 		<td><input type="text" name="tel" value="${dto.tel}"></td>
	 	</tr>
	 	<tr>
	 		<th>사업자명</th>
	 		<td><input type="text" name="name" value="${dto.name}"></td>
	 	</tr>
	 	<tr>
	 		<th>기본정보</th>
	 		<td><textarea name="information">${dto.information}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>공지사항</th>
	 		<td><textarea name="notice">${dto.notice}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>취소규정</th>
	 		<td><textarea name="cancel_notice">${dto.cancel_notice}</textarea></td>
	 	</tr>
	 	<tr>
	 		<th>스토어 이미지 등록</th>
	 		<td>
				<input type="file" name="upload" class="boxTF" size="53" accept="image/*" >
			</td>
	 	</tr>
	 	</tbody> 
	 	
	 	<c:if test="${mode=='update'}">
		   <c:forEach var="vo" items="${listFile}">
				  <tr id="f${vo.fileCode}"> 
				      <th>등록된 객실 이미지</th>
				      <td> 
							${vo.originalFilename}
							| <a href="javascript:deleteFile('${vo.fileCode}');">삭제</a>	        
				      </td>
				  </tr>
		   </c:forEach>
		</c:if>
	 	
	</table>
	<div class="btn_wrap view_btn">
		
			<button type='button' class='button btn_blk insertStoreSubmit' onclick="sendStore('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
			<button type='button' class='button btn_blk insertStoreCancel' onclick="location.href='<%=cp%>/store/storeInfo/list';">${mode=='update'?'수정취소':'등록취소'}</button>
		
		
		<c:if test="${mode=='update'}">
         	 <input type="hidden" name="storeCode" value="${dto.storeCode}">
         	 <input type="hidden" name="saveFilename" value="${dto.saveFilename}">
        	 <input type="hidden" name="page" value="${page}">
		</c:if>
	</div>

  </form>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>