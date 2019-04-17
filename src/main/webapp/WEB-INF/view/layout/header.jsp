<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
  <h1 id="logo"><a href="<%=cp%>/main">WAYOU</a></h1>
            <!-- 로고있는 경우 하단 태그 사용 -->
            <!-- <h1 id="logo"><a href="/"><img src="./resource/images/common/logo.png" alt="카카오" /></a></h1> -->
			<a href="#" class="btn_gnb">
				<i></i>
				<span class="blind">메뉴</span>
			</a>
			<div>
				<div class="head_timer">
					<div class="date"></div>
					<div class="clock"></div>
				</div>
				<div class="head_info">
					
					<c:if test="${sessionScope.admin != null}">
						<span><strong>${sessionScope.admin.adminName}</strong>님 안녕하세요.</span>
						<a href="<%=cp%>/admin/logout" class="button h22">로그아웃</a>
						<a href="<%=cp%>/admin/Myupdate" class="button h22">내정보 수정</a>
					</c:if>
					<c:if test="${sessionScope.admin == null}">
						<a href="<%=cp%>/admin/login" class="button h22">로그인</a>
					</c:if>
				</div>
</div>
