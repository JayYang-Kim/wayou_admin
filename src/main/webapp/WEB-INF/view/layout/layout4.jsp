<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
// String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp;
%>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="ko"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8" lang="ko"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9" lang="ko"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="ko"> <!--<![endif]-->
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    
    <title>WAYOU - 누워서 유람하듯 여행을 떠나요</title>

    <!-- Favicon - 파비콘 (주소창 영역 아이콘) -->
    <link rel="Shortcut Icon" href="<%=cp%>/resource/images/common/wayou.ico"/>

	<!-- style -->
	<link rel="stylesheet" href="<%=cp%>/resource/css/common.css" media="all" />
	<link rel="stylesheet" href="<%=cp%>/resource/css/contents.css" media="all" />

	<!-- javascript -->
	<script src="<%=cp%>/resource/js/lib/jquery-1.12.4.min.js"></script>
	<script src="<%=cp%>/resource/js/lib/jquery-migrate-1.4.1.min.js"></script>
	<script src="<%=cp%>/resource/js/lib/jquery-ui-1.12.1.min.js"></script>
    
    <script src="<%=cp%>/resource/js/lib/util-jquery.js"></script>
    <script src="<%=cp%>/resource/js/lib/util.js"></script>
    
    <script src="<%=cp%>/resource/js/plugins.js"></script>
	<script src="<%=cp%>/resource/js/ui_script.js"></script>
	<script src="<%=cp%>/resource/js/basic.js"></script>
    <!-- //javascript -->
    
	<!--[if lt IE 9]>
		<script src="<%=cp%>/resource/js/lib/html5shiv.js"></script>
	<![endif]-->
</head>

<body>
	<div id="wrap">
		<header id="header">
			<tiles:insertAttribute name="header"/>
		</header>
		
		<aside class="left_menu">
				<tiles:insertAttribute name="left"/>
		</aside>
		
		<div id="container">
			<section id="contents">
	            <tiles:insertAttribute name="body"/>
		    </section>        
		</div>
	</div>
	<footer id="footer">
	    <tiles:insertAttribute name="footer"/>
	</footer>
	
	<!-- pop_layer -->
	<div id="popup" class="pop_bg">
		<article class="pop_wrap">
			<h1>팝업 타이틀</h1>
			<div class="pop_cont">
				<p>내용<br/>내용</p>
				<p class="t_center mt20">
					<a href="#" class="button w72 btn_gray">취소</a>
					<a href="#" class="button w72 btn_red">등록</a>
				</p>
			</div>
			<!-- 팝업을 닫을때는 .pop_close 클래스를 활용 하거나, popupHide 함수 활용 -->
			<a href="#" class="btn_close pop_close">닫기</a>
		</article>
	</div>
</body>
</html>