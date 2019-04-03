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
<html>
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
	<link rel="stylesheet" href="<%=cp%>/resource/css/loginStyle.css" media="all" />

	<!-- javascript -->
	<script src="<%=cp%>/resource/js/lib/jquery-1.12.4.min.js"></script>
	<script src="<%=cp%>/resource/js/lib/jquery-migrate-1.4.1.min.js"></script>
	<script src="<%=cp%>/resource/js/lib/jquery-ui-1.12.1.min.js"></script>
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
	<![endif]-->
	<script src="<%=cp%>/resource/js/plugins.js"></script>
	<script src="<%=cp%>/resource/js/ui_script.js"></script>
	<!-- //javascript -->
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
    <div class="body-container">
        <div class="body-right">
            <tiles:insertAttribute name="body"/>
        </div>
    </div>        
</div>
<footer id="footer">
    <tiles:insertAttribute name="footer"/>
</footer>
</div>


<%-- <script type="text/javascript" src="<%=cp%>/resource/admin/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/admin/jquery/js/jquery.ui.datepicker-ko.js"></script>
 --%>
 </body>
</html>