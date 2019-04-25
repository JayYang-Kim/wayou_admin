<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">


$(function() {

	$(".btnInsertHotel").click(function() {	
		
		var isClass = $("#insertForm").hasClass("insertHotel");
		if(isClass) {
			$("#insertForm").removeClass("insertHotel");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/hotel/hotelInfo/insertHotel";
		$.ajax({
			type:"get",
			url:url,
			dataType : "html",
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertHotel");
			},
			beforeSend:function(e) {
				e.setRequestHeader("AJAX", true);
			},
			error:function(e) {
				if(e.status==403){
					location.href="<%=cp%>/wadmin/admin/login";
					return;
				}
				console.log(e.responseText);
			}
		});
	});
	
	
});


function sendHotel(mode) {
    var f = document.insertHotelForm;
		
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
 
	if(mode=="created") {
		searchKey="hname";
		searchValue="";
		pageNo=1;
		f.action="<%=cp%>/hotel/hotelInfo/insertHotel";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/hotelInfo/updateHotel";
	}
 
	
    f.submit();

}

$(function() {

	$(".btnUpdateHotel").click(function() {	

		var isClass = $("#insertForm").hasClass("insertHotel");
		if(isClass) {
			$("#insertForm").removeClass("insertHotel");
			$("#insertForm").empty();
			return false;
		}
	
		var url="<%=cp%>/hotel/hotelInfo/updateHotel";
		var query="hotelCode="+$(this).attr("data-hotelCode");
		
		$.ajax({
			type:"get",
			url:url,
			data:query,
			success:function(data){
				$("#insertForm").html(data);
				$("#insertForm").addClass("insertHotel");
			},
			beforeSend:function(e) {
				e.setRequestHeader("AJAX", true);
			},
			error:function(e) {
				if(e.status==403){
					location.href="<%=cp%>/wadmin/admin/login";
					return;
				}
				console.log(e.responseText);
			}
		});
	});
	
	
});

	


function hotel_Postcode() {
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


<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>숙박 등록ㆍ관리</strong></p>
</div>

<div>
	<div class="list_search_wrap">
		<div class="list_search">
			<select name="searchKey" id="searchKey" title="검색조건선택">
				<option value="hname">호텔명</option>
				<option value="location">지역</option>
				<option value="name">사업자명</option>
			</select>
			<input type="text" name="searchValue" id="searchValue" title="검색내용입력" />
			<span class="btn">
				<a class="button" onclick="searchList();" style="border: none;">검색</a>
			</span>
		</div>
	</div>
	<div class="hotel-body" style="width: 100%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="100">호텔명</th>
					<th width="50">지역</th>
					<th width="70">사업자명</th>
					<th width="100" colspan="2">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.hname}</td>
						<td>${dto.locName}</td>
						<td>${dto.name}</td>
						<td><button type='button' class='button btnUpdateHotel' data-hotelCode="${dto.hotelCode}">호텔 정보 수정</button></td>
						<td><button type='button' class='button btnInsertRoom' onclick="location.href='<%=cp%>/hotel/hotelInfo/roomInfo/list?hotelCode=${dto.hotelCode}';">객실 추가ㆍ수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
				${paging}
			</td>
		   </tr>
		</table>
	</div>
	
	<div>
		<div class="btn_wrap view_btn">
			<button type='button' class='button btn_blk btnInsertHotel'>새로운 호텔 등록</button>
		</div>
		<div id="insertForm" class="mt30">
			
		</div>
	</div>

</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>