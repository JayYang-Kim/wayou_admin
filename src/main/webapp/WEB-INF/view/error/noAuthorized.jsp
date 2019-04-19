<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
   response.setStatus(HttpServletResponse.SC_OK);
%>

<div class="container">
	<div>
	    <div style="margin: 120px auto 30px; width:420px; min-height: 350px;">
	    	<div style="text-align: center;">
	        	<span style="font-weight: bold; font-size:27px; color: #424951;">${title}</span>
	        </div>
	        
	        <div class="messageBox">
	            <div style="line-height: 150%; padding-top: 35px;">권한이 없는 계정입니다.</div>
	            <div style="margin-top: 20px;">
                      <button type="button" onclick="javascript:history.back();" class="btnConfirm">이전화면으로 이동</button>
                 </div>
	        </div>
	     </div>   
    </div>
</div>
