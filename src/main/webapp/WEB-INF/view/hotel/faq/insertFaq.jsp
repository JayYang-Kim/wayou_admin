<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">

function sendOk() {
	var f=document.FaqInsertForm;


	var str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.answerContent.focus();
        return;
    }
	
	f.action="<%=cp%>/hotel/faq/insertFaq";
	
	f.submit();
}



</script>
    
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
			        <button type='button' class="btn" onclick="sendOk();">답변 등록하기</button>
			        <button type="reset" class="btn">다시입력</button>
					<c:if test="${mode=='update'}">
			         	 <input type="hidden" name="qnaCode" value="${dto.faqCode}">
			         	 
			         </c:if>
			        	 <input type="hidden" name="page" value="${page}">
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    

      

	

	
	