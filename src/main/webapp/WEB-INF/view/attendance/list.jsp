<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<body>
<div class="container">
<div class="row">
<div class="col - 12 col -6">
	출퇴근 버튼 들어갈 곳(출근시간)
</div>
<div class="col - 12 col -6">
	날씨 api 들어갈 곳(퇴근시간)
</div>
(오늘 일한 시간)
</div>
</div>

<div style="text-align: center;">

<h1 style="color:tomato;">TODAY</h1><h1>${todayMonth}월&nbsp;${todayDate}일</h1></div>

<table >
	<tr height="60">
	     <td width="200">&nbsp;</td>
	     <td align="center">
	         <span class="btnDate" onclick="changeDate(${year}, ${month-1});">이전주</span>
	         <span class="titleDate">${year}년 ${month}월</span>
	         <span class="btnDate" onclick="changeDate(${year}, ${month+1});">다음주</span>
	   	</td>
	   	<td width="200">&nbsp;</td>
	</tr>
</table>

<div style="width:100%; overflow:auto">
<table class="table" style="width: 800px; margin:0px auto; border-spacing: 0;" >
	<tr>
		<td rowspan='2' width="100">요일/날짜</td>		
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
		<td>출근</td>
		<c:forEach var='d' items="${days}">
			<th>
				&nbsp;
			</th>
		</c:forEach>
	</tr>
	<tr>
	<td>퇴근</td>
	<c:forEach var='d' items="${days}">
			<th>
				&nbsp;
			</th>
		</c:forEach>
	</tr>
</table>

<table>
	<tr>
		<th>부서</th>
		<th>직책</th>
		<th>성명</th>
		<th>출근 상태</th>
	</tr>
	<tr>
		<td>관리</td>
		<td>대리</td>
		<td>김진양</td>
		<td>출근(파랑)</td>
	</tr>
</table>
</div>
</body>