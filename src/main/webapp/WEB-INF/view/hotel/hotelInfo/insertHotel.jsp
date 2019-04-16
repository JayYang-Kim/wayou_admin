<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>



<div>
  <form name="insertHotelForm" method="post" enctype="multipart/form-data">
	<table class="table left_tbl form_tbl">
	<colgroup>
		<col style="width:30%">
		<col>
	</colgroup>
	 	<tr>
	 		<th >호텔명</th>
	 		<td><input type="text" name="hname" value="${dto.hname}"></td>
	 	</tr>
	 	<tr>
	 		<th>지역</th>
	 		<td>
	 			<select id="locCode" name="locCode">
	 				<option value="1">서울</option>
    				<option value="2">인천</option>
    				<option value="3">광주</option>
	 			</select>
	 		</td>
	 	</tr>
	 	<tr>
	 		<th>주소</th>
	 		<td>
		 		<input type="text" id="postcode" placeholder="우편번호">
				<input type="button" onclick="hotel_Postcode()" value="우편번호 찾기"><br>
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
	 	<th>호텔 이미지 등록</th>
	 	<td>
			<input type="file" placeholder="첨부파일을 선택해주세요." title="첨부파일 선택" readonly="readonly">
		</td>
	 	</tr>
	</table>
	<div class="btn_wrap view_btn">
			<button type='button' class='button btn_blk insertHotelSubmit' onclick="sendOk();">등록완료</button>
			<button type='button' class='button btn_blk insertHotelCancel'>등록취소</button>
	</div>

  </form>
</div>

