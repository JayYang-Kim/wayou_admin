<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<div class="mainbody">
	
    <div style="width:100%; height:350px; padding: 20px;">
      	<div style=" float: left; width: 33%; text-align: center; position: relative; ">
      		<div><img src="<%=cp%>/resource/images/common/gray.png" width="200px;"></div>
      		<div><p style="position: absolute; top: 50%; left: 50%; transform: translate( -50%, -90% ); font-size:40px;">10</p></div>
      		<p style="font-size:20px; margin-top: 20px;">예약완료</p>
      	</div>
		<div style="float: left; width: 33%; text-align: center; position: relative; ">
      		<div><img src="<%=cp%>/resource/images/common/gray.png" width="200px;"></div>
      		<div><p style="position: absolute; top: 50%; left: 50%; transform: translate( -50%, -90% ); font-size:40px;">5</p></div>
      		<p style="font-size:20px; margin-top: 20px;">예약취소</p>
      	</div>
		<div style="float: left; width: 33%; text-align: center; position: relative; ">
      		<div><img src="<%=cp%>/resource/images/common/gray.png" width="200px;"></div>
      		<div><p style="position: absolute; top: 50%; left: 50%; transform: translate( -50%, -90% ); font-size:40px;">7</p></div>
      		<p style="font-size:20px; margin-top: 20px;">문의사항</p>
      	</div>
    </div>

    <div style="height:350px;">
    	<div style="float:left; width: 48%; height: 100%;">
    	<p class="f20" style="margin-left: 36%;">오늘의 예약내역</p>
    	 <table class="table td_bor_no" style="float:left; width: 90%; margin-top: 10px;">
    	 	<thead>
	    	 	<tr>
	    	 		<th>예약번호</th>
	    	 		<th>호텔명</th>
	    	 		<th>객실명</th>
	    	 		<th>예약자</th>
	    	 		<th>체크인날짜</th>
	    	 	</tr>
    	 	</thead>
    	 	<tbody>
    	 		<c:forEach var="i" begin="1" end="5" step="1">
		    	 	<tr>
		    	 		<td>123456</td>
		    	 		<td>와유호텔</td>
		    	 		<td>와유방</td>
		    	 		<td>김진양</td>
		    	 		<td>2019-04-07</td>
		    	 	</tr>
	    	 	</c:forEach>
    	 	</tbody>
    	 </table>
    	</div>
    	
    	<div style="width: 49%; float: left;">
 
    	</div>
    </div>
</div>
