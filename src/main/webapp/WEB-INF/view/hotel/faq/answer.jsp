<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">

function sendOk() {
	var f=document.QnaAnswerForm;


	var str = f.answerContent.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.answerContent.focus();
        return;
    }
	
	f.action="<%=cp%>/hotel/qna/insertAnswer";
	
	f.submit();
}



</script>
    
    <div>
			<form name="QnaAnswerForm" method="post">
			  <table class="table tbl_view">
			  <colgroup>
				<col style="width:15%"/>
				<col />

			</colgroup>
			  <tr > 
			      <th colspan="2" >
			        ${dto.subject}
				  </th>
			  </tr>
			
			  <tr> 
			      <th>작성자</th>
			      <td style="padding-left:10px;"> 
			           ${dto.userName}
			      </td>
			  </tr>
			
			  <tr> 
			      <th>문의 내용</th>
			      <td> 
			        ${dto.content}
			      </td>
			  </tr>
			  <tr>
			  	<th>
			  		답변
			  	</th>
			  	<td>
			  		<textarea name="answerContent" class="boxTA" style="width: 95%;">${dto.answerContent}</textarea>
			  	</td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">답변 등록하기</button>
			        <button type="reset" class="btn">다시입력</button>
			        
	
			         	 <input type="hidden" name="qnaCode" value="${dto.qnaCode}">
			        	 <input type="hidden" name="page" value="${page}">
			        	 <input type="hidden" name="catCode" value="${catCode}">

			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    

      

	

	
	