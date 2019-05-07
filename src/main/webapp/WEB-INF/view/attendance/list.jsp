<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lib/weather-icons.min.css" media="all" />
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}
function sendAt() {
	var url="<%=cp%>/attendance/inAtt";
	$.ajax({
		type:"GET",
		url:url,
		success:function(data){
			var startTime = data.startTime;
			console.log(startTime);
			if(startTime!=null){
			$("#startTime").html(startTime);
			$("#sendAt").attr("disabled","disabled");
			}
		},beforeSend:function(e){
			e.setRequestHeader("AJAX",true);
		},error:function(e){
			if(e.status==403){
				location.href="<%=cp%>/attendance/list";
				return;
			}
			console.log(e.reponseText);
		}
	});
}

function putAt() {
	var url="<%=cp%>/attendance/outAtt";
	$.ajax({
		type:"GET",
		url:url,
		success:function(data){
			var endTime = data.endTime;
			var dayTotal = data.dayTotal;
			console.log(endTime);
			console.log(dayTotal);
			if(endTime!=null){
				$("#endTime").html(endTime);
				$("#putAt").attr("disabled","disabled");
			}
 			if(dayTotal!=null){
					var hour = (dayTotal)/60;
					$("#hour").html(hour+"시간");
 			}
		},beforeSend:function(e){
			e.setRequestHeader("AJAX",true);
		},error:function(e){
			if(e.status==403){
				location.href="<%=cp%>/attendance/list";
				return;
			}
			console.log(e.reponseText);
		}
	});
}


var weather;
var temp;
var wind;
var humidity;
var cloudp;

</script>
<body>
<h1 id="page_tit">직원관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>출/퇴근 관리</h2>
	<p><strong>출/퇴근 리스트</strong></p>
</div>
<div class="container">
	<div style="border-bottom:2px solid; width:95%; height:170px; margin:auto;">
		<div class="row" style="margin-top:30px">
			<div class="col-12 col-lg-4" style="text-align:center;">
				<button class="button h30 w70 btn_blue" id="sendAt" onclick="sendAt()" style="width:100px; height:100px; font-size:30px;">출근</button>
			</div>
			<div class="col-12 col-lg-4" style="text-align:center">
				<button class="button h30 w70 btn_red" id="putAt" onclick="putAt()"style="width:100px; height:100px; font-size:30px;">퇴근</button>
			</div>
			<div class="col-12 col-lg-4">
			<table>
				<tr>
					<td><img id="icon" ></img><span style="font-size: 15px;">서울</span></td>
					<td id="temp" style="font-size:20px; font-weight: bold; text-align: right"></td>
					<td><i class="wi wi-celsius" style="font-size:30px"></i></td>
				</tr>
				<tr>
					<td><i class="wi wi-strong-wind" style="font-size:25px; text-align:center;"></i></td>
					<td><i class="wi wi-humidity" style="font-size:25px; text-align:center;"></i></td>
					<td><i class="wi wi-cloud" style="font-size:25px; text-align:center;"></i></td>
				</tr>
				<tr>
					<td id="wind" style="font-size:15px; font-weight: bold;"></td>
					<td id="humidity" style="font-size:15px; font-weight: bold;"></td>
					<td id="clouds" style="font-size:15px; font-weight: bold;"></td>
				</tr>
			</table>
			</div>
		</div>
		<div class="row" style="margin-top:15px">
			<div class="col-12 col-lg-4" style="text-align: center;">
				(출근시간)<span id="startTime"></span>
			</div>
			<div class="col-12 col-lg-4" style="text-align: center;">
				(퇴근시간)<span id="endTime"></span>
			</div>
			<div class="col-12 col-lg-4" style="text-align: center;">
				(당일 업무시간)<span id="hour">시간</span>
			</div>
		</div>
	</div>
</div>

<div class="container">
<div class="list_search_wrap">
	<div class="search_clean">
		<button type="button" class="button" onclick="location.href='<%=cp%>/attendance/list'">새로고침</button>
	</div>
	<form name="searchForm" action="<%=cp%>/attendance/list" method="post">
		<div class="list_search">
			<select name="condition">
           		<option value="departCode" ${condition == 'departCode' ? "selected='selected'" : ""}>부서</option>
           		<option value="positionCode" ${condition == 'positionCode' ? "selected='selected'" : ""}>직책</option>
           		<option value="adminName" ${condition == 'adminName' ? "selected='selected'" : ""}>이름</option>
           		<option value="created" ${condition == 'created' ? "selected='selected'" : ""}>작성일</option>
			</select>
			<input type="text" name="word" value="${word}" />
			<button type="button" class="button" onclick="searchList()">검색</button>
		</div>
	</form>
</div>
<table class="table" >
	<tr>
		<th>부서</th>
		<th>직책</th>
		<th>성명</th>
		<th>출근 상태</th>
		<c:if test="${departCode == 4 || idnCode ==2 }">
		<th>출근 시간</th>
		<th>퇴근 시간</th>
		<th>업무 시간</th>
		</c:if>
		<th>날짜</th>
	</tr>
	<c:forEach var="dto" items="${listAtt}">
	<tr>
		<td>${dto.departName}</td>
		<td>${dto.positionName}</td>
		<td>${dto.adminName}</td>
		<c:if test="${dto.endTime == null }">
		<td style='color:blue'>출근</td>
		</c:if>
		<c:if test="${dto.endTime != null }">
		<td style='color:red'>퇴근</td>
		</c:if>
		<c:if test="${departCode == 4 || idnCode ==2 }">
		<th>${dto.startTime }</th>
		<th>${dto.endTime }</th>
		<th>${dto.dayTotal/60 } 시간</th>
		</c:if>
		<td>${dto.created }</td>
	</tr>
	</c:forEach>
</table>
	<div class="t_center mt30">
	${paging}
	</div>
</div>
</body>
<script type="text/javascript">
var city = "seoul"
var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"3d96f526befdc6e30ba32bad89a0e95b";
$.ajax({
    url: apiURI,
    dataType: "json",
    type: "GET",
    async: "false",
    success: function(resp) {
        temp=Math.round(resp.main.temp-273.15);
    	$("#temp").html(temp+"&nbsp;&nbsp;");
        humidity=resp.main.humidity;
    	$("#humidity").html(humidity+"%");
        weather= resp.weather[0].main;
        wind=resp.wind.speed;
    	$("#wind").html(wind+"m/s");
        clouds=(resp.clouds.all) +"%";	
    	$("#clouds").html(clouds);
        var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
    	$("#icon").attr("src", imgURL);
    }
})

</script>