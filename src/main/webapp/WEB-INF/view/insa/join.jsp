<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<table class="table left_tbl form_tbl">
		<caption>인사 등록</caption>
		<colgroup>
			<col style="width:15%" />
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><b class="t_red">*</b> 체크박스</th>
				<td>
					<div class="inp_wid wid2">
						<label class="checkbox">
							<input name="checkbox2" type="checkbox" checked="checked" />
							<span class="lbl">checkbox1</span>
						</label>
						<label class="checkbox">
							<input name="checkbox2" type="checkbox" />
							<span class="lbl">checkbox2</span>
						</label>
					</div>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> inp_wid</th>
				<td>
					<div class="inp_wid">
						<input type="text" placeholder="내용입력" title="내용입력" />
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> wid2</th>
				<td>
					<div class="inp_wid wid2">
						<select title="옵션선택">
							<option value="">옵션선택</option>
						</select>
						<input type="text" placeholder="내용입력" title="내용입력" />
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> wid3</th>
				<td>
					<div class="inp_wid wid3">
						<select title="옵션선택">
							<option value="">옵션선택</option>
						</select>
						<input type="text" placeholder="내용입력" title="내용입력" />
						<input type="text" placeholder="내용입력" title="내용입력" />
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><b class="t_red">*</b> wid4</th>
				<td>
					<div class="inp_wid wid4">
						<select title="옵션선택">
							<option value="">옵션선택</option>
						</select>
						<input type="text" placeholder="내용입력" title="내용입력" />
						<input type="text" placeholder="내용입력" title="내용입력" />
						<a href="#" class="button">button</a>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">textarea</th>
				<td>
					<textarea name="" id="" cols="30" rows="10"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>