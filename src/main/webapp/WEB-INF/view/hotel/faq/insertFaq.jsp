<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">

function sendOk(mode) {
	var f=document.FaqInsertForm;


	var str = f.subject.value;
    if(!str) {
        alert("질문을 입력하세요. ");
        f.subject.focus();
        return;
    }
    
    var str = f.content.value;
    if(!str) {
        alert("답변을 입력하세요. ");
        f.content.focus();
        return;
    }
	
	
	if(mode=="created") {
		f.action="<%=cp%>/hotel/faq/insertFaq";
	}
	
	if(mode=="update") {
		f.action="<%=cp%>/hotel/faq/update";
	}
	
	f.submit();
}



</script>

<h1 id="page_tit">숙박관리</h1>
<!-- 현재 페이지 정보 -->
<div class="page_info">
	<h2>숙박관리</h2>
	<p><strong>자주하는질문</strong></p>
</div>

    <div>
			<form name="FaqInsertForm" method="post">
			  <table class="table tbl_view">
			  <colgroup>
				<col style="width:15%"/>
				<col />

			</colgroup>
			  <tr > 
			      <th colspan="2" >
			        &nbsp;
				  </th>
			  </tr>
			
			  <tr> 
			      <th>작성자</th>
			      <td style="padding-left:10px;"> 
			           ${sessionScope.admin.adminId}
			      </td>
			  </tr>
			
			  <tr> 
			      <th>문의 내용</th>
			      <td>
			      	<input type="text" name="subject" value="${dto.subject}">
			      </td>
			  </tr>
			  <tr>
			  	<th>
			  		답변
			  	</th>
			  	<td>
			  		<textarea name="content" class="boxTA" style="width: 95%;">${dto.content}</textarea>
			  	</td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type='button' class="btn" onclick="sendOk('${mode}');">${mode=='update'?'수정완료':'등록완료'}</button>
			        <button type="reset" class="btn">다시입력</button>
					<c:if test="${mode=='update'}">
			         	 <input type="hidden" name="faqNum" value="${dto.faqNum}">
			         	 
			         </c:if>
			        	 <input type="hidden" name="page" value="${page}">
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    

      

	

	
	