<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script>
function changeDate(year, month) {
	var url="<%=cp%>/hotel/reserve/list2?year="+year+"&month="+month;
	location.href=url;
}

</script>
<div style="text-align: center;">

<h1 style="color:tomato;">TODAY</h1><h1>${todayMonth}월&nbsp;${todayDate}일</h1></div>

<table >
	<tr height="60">
	     <td width="200">&nbsp;</td>
	     <td align="center">
	         <span class="btnDate" onclick="changeDate(${year}, ${month-1});">이전달</span>
	         <span class="titleDate">${year}년 ${month}월</span>
	         <span class="btnDate" onclick="changeDate(${year}, ${month+1});">다음달</span>
	   	</td>
	   	<td width="200">&nbsp;</td>
	</tr>
</table>

<div style="width:100%; overflow:auto">
<table class="table" style="width: 800px; margin:0px auto; border-spacing: 0;" >
	<tr>
		<td rowspan='2' width="100">호텔명</td>
		<td rowspan='2' width="70">룸호수</td>
		
		<c:forEach var='w' items="${weeks}">
			<td width="50" style="border-bottom: none;">
				${w}
			</td>
		</c:forEach>
	</tr>

	<tr>
		<c:forEach var='d' items="${days}">
			<th style="border-top: none;">
				${d}
			</th>
		</c:forEach>
	</tr>
	<tr>
		
		<td rowspan="2">와유호텔</td>
		<td>102호</td>
		<c:forEach var='d' items="${days}">
			<th>
				&nbsp;
			</th>
		</c:forEach>
	</tr>
	<tr>
	<td>103호</td>
	<c:forEach var='d' items="${days}">
			<th>
				&nbsp;
			</th>
		</c:forEach>
	</tr>

</table>
</div>
