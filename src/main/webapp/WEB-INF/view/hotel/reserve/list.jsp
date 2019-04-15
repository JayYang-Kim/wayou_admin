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
	
	$(".btnInsertHotel").click(function() {
		
	})
});

function sendOk() {
    var f = document.insertHotelForm;
    
	// alert(f.hname.value);
 
	f.action="<%=cp%>/hotel/hotelInfo/insertHotel";

    f.submit();

}


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




<div class="body">
	<div style="height: 50px; margin-left: 20px;">
		<h1>호텔 List</h1>
	</div>
	<div style="width: 95%;">
		<table class="table td_bor_no" style="width: 100%;">
			<thead>
				<tr>
					<th width="100">호텔명</th>
					<th width="70">사업자명</th>
					<th width="100" colspan="2">관리</th>
				</tr>
			</thead>
			<tbody>
				
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><button type='button' class='button btn_blk btnInsertRoom'>호텔 정보 수정</button></td>
						<td><button type='button' class='button btn_blk btnInsertRoom'>객실 추가ㆍ수정</button></td>
					</tr>
				
			</tbody>
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