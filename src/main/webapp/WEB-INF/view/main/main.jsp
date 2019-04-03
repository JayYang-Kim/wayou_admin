<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

			<!-- contents -->
			<section id="contents">
				<h1 id="page_tit">브랜드 로고</h1>
				<!-- 현재 페이지 정보 -->
				<div class="page_info">
					<h2>기본정보</h2>
					<p>제품 &gt; <strong>기본정보</strong></p>
				</div>

				<div class="guide cont_inner">
					<h2>텍스트</h2>
					<h3>컬러</h3>
					<div class="line_box">
						<p>default - #666</p>
						<p class="t_wht" style="background:#000;">.t_wht</p>
						<p class="t_blk">.t_blk</p>
						<p class="t_gray">.t_gray</p>
						<p class="t_red">.t_red</p>
						<p class="t_grn">.t_grn</p>
						<p class="t_org">.t_org</p>
						<p class="t_blue">.t_blue</p>
						<br>
						<p class="midline">.midline</p>
						<p class="udline">.udline</p>
					</div>
					
					
					<h2>버튼</h2>
					<div class="line_box">
						<p>
							<a href="#" class="button">a 태그</a>
							<button class="button">button</button>
							<input type="button" class="button" value="input[button]" />
							<input type="submit" class="button" value="input[submit]" />
						</p>
                        <br/>
                        <p>
                            <input type="button" class="btn" value="btn"/>
                            <input type="button" class="btn_classic" value="btn_classic"/>
                            <input type="button" class="button" value="button"/>
                            <input type="button" class="btn_radius" value="btn_radius"/>
                        </p>
						<br>
						<p>
							<a href="#" class="button h20">button h20</a>
							<a href="#" class="button">defalut</a>
							<a href="#" class="button h30">button h30</a>
							<a href="#" class="button h40">button h40</a>
						</p>
						<br>
                        <p>
                            <input type="button" class="btn btn-white" value="btn-white"/>
                            <input type="button" class="btn btn-black" value="btn-black"/>
                            <input type="button" class="btn btn-green" value="btn-green"/>
                            <input type="button" class="btn btn-purple" value="btn-purple"/>
                            <input type="button" class="btn btn-orange" value="btn-orange"/>
                            <input type="button" class="btn btn-pink" value="btn-pink"/>
                            <input type="button" class="btn btn-turquoise" value="btn-turquoise"/>
                            <input type="button" class="btn btn-yellowGreen" value="btn-yellowGreen"/>
                            <input type="button" class="btn btn-lightBlue" value="btn-lightBlue"/>
                            <input type="button" class="btn btn-blue" value="btn-blue"/>
                            <input type="button" class="btn btn-red" value="btn-red"/>
                            <input type="button" class="btn btn-darkRed" value="btn-darkRed"/>
                            <input type="button" class="btn btn-yellow" value="btn-yellow"/>
                            <input type="button" class="btn btn-gray" value="btn-gray"/>
                            <input type="button" class="btn btn-lightGray" value="btn-lightGray"/>
                            <input type="button" class="btn btn-darkGray" value="btn-darkGray"/>
                        </p>
                        <br>
                        <p>
                            <input type="button" class="btn btn-bg-white" value="btn-bg-white"/>
                            <input type="button" class="btn btn-bg-black" value="btn-bg-black"/>
                            <input type="button" class="btn btn-bg-green" value="btn-bg-green"/>
                            <input type="button" class="btn btn-bg-purple" value="btn-bg-purple"/>
                            <input type="button" class="btn btn-bg-orange" value="btn-bg-orange"/>
                            <input type="button" class="btn btn-bg-pink" value="btn-bg-pink"/>
                            <input type="button" class="btn btn-bg-turquoise" value="btn-bg-turquoise"/>
                            <input type="button" class="btn btn-bg-yellowGreen" value="btn-bg-yellowGreen"/>
                            <input type="button" class="btn btn-bg-lightBlue" value="btn-bg-lightBlue"/>
                            <input type="button" class="btn btn-bg-blue" value="btn-bg-blue"/>
                            <input type="button" class="btn btn-bg-red" value="btn-bg-red"/>
                            <input type="button" class="btn btn-bg-darkRed" value="btn-bg-darkRed"/>
                            <input type="button" class="btn btn-bg-yellow" value="btn-bg-yellow"/>
                            <input type="button" class="btn btn-bg-gray" value="btn-bg-gray"/>
                            <input type="button" class="btn btn-bg-lightGray" value="btn-bg-lightGray"/>
                            <input type="button" class="btn btn-bg-darkGray" value="btn-bg-darkGray"/>
                        </p>
                        <br>
                        <p>
                            <input type="button" class="btn" value="btn"/>
                            <input type="button" class="btn_classic" value="btn_classic"/>
                            <input type="button" class="button" value="button"/>
                            <input type="button" class="btn_radius" value="btn_radius"/>
                        </p>
						<br>
						<p>
							<a href="#" class="button">defalut</a>
							<a href="#" class="button btn_gray">btn_gray</a>
							<a href="#" class="button btn_blk">btn_blk</a>
							<a href="#" class="button btn_wht">btn_wht</a>
							<a href="#" class="button btn_yellow">btn_yellow</a>
							<a href="#" class="button btn_red">btn_red</a>
							<a href="#" class="button btn_blue">btn_blue</a>
							<a href="#" class="button btn_grn">btn_grn</a>
							<a href="#" class="button btn_brown">btn_brown</a>
						</p>
						<br>
						<p>
							<span class="btn_sort">
								<a href="#" class="on">금일</a><a href="#">1일전</a><a href="#">2일전</a>
							</span>	
						</p>
						<br>
						<p><a href="#" class="btn_onoff onoffAction"><span>NO</span><span>YES</span><i>가림영역</i></a></p>
					</div>
					
					<h2>form요소</h2>
					<h3>체크박스</h3>
					<div class="line_box">
						<div class="inp_wid wid3">
							<label class="checkbox">
								<input name="checkbox" type="checkbox" checked="checked" />
								<span class="lbl">checkbox1</span>
							</label>
							<label class="checkbox">
								<input name="checkbox" type="checkbox" />
								<span class="lbl">checkbox2</span>
							</label>
							<label class="checkbox">
								<input name="checkbox" type="checkbox" disabled="disabled" />
								<span class="lbl">checkbox3</span>
							</label>
						</div>
						<br />
						<p>
							<label class="switch">
								<input type="checkbox">
								<span></span>
							</label>
						</p>
					</div>
					<h3>라디오버튼</h3>
					<div class="line_box">
						<div class="inp_wid wid3">
							<label class="radio">
								<input name="radio1" type="radio" checked="checked" />
								<span class="lbl">radio1</span>
							</label>
							<label class="radio">
								<input name="radio1" type="radio" />
								<span class="lbl">radio2</span>
							</label>
							<label class="radio">
								<input name="radio" type="radio" disabled="disabled" />
								<span class="lbl">radio3</span>
							</label>
						</div>					
					</div>
					<h3>input - text</h3>
					<div class="line_box">
						<p><input type="text" placeholder="default" title="내용입력" /></p>
						<br />								
						<p><input type="text" class="w_100" placeholder="readonly" title="내용입력" readonly="readonly" /></p>
						<br />
						<p><input type="text" placeholder="disabled" title="내용입력" disabled="disabled" /></p>
					</div>
					<h3>input - file</h3>
					<div class="line_box">
						<p><input type="file" class="w_100" placeholder="파일첨부" title="파일첨부" /></p>
						<br />
						<p class="inp_file">
							<input type="text" placeholder="첨부파일을 선택해주세요." title="첨부파일 선택" readonly="readonly">
							<span class="btn_file">
								<a href="#" class="button">파일찾기</a>
								<input type="file" placeholder="내용입력" title="파일첨부">
							</span>
						</p>
						<br />
						<span class="inp_file">
							<input type="text" placeholder="첨부파일을 선택해주세요." title="첨부파일 선택" readonly="readonly">
							<span class="btn_file">
								<a href="#" class="button">파일찾기</a>
								<input type="file" placeholder="내용입력" title="파일첨부">
							</span>
						</span>
					</div>
					<h3>select</h3>
					<div class="line_box">
						<p>
							<select title="옵션선택">
								<option value="">default</option>
								<option value="">옵션1</option>
								<option value="">옵션2</option>
								<option value="">옵션3</option>
							</select>
						</p>
						<br />
						<p>
							<select class="w_100" title="옵션선택">
								<option value="">default</option>
								<option value="">옵션1</option>
								<option value="">옵션2</option>
								<option value="">옵션3</option>
							</select>
						</p>
						<br />								
						<p>
							<select title="옵션선택" disabled="disabled">
								<option value="">disabled</option>
								<option value="">옵션1</option>
								<option value="">옵션2</option>
								<option value="">옵션3</option>
							</select>
						</p>
					</div>
					<h3>textarea</h3>
					<div class="line_box">
						<p><textarea placeholder="내용입력" title="내용입력"></textarea></p>
						<br />
						<p><textarea placeholder="내용입력" title="내용입력" disabled></textarea></p>
					</div>
			
					<h3>datepicker</h3>
					<p class="line_box"><input class="datepicker" type="text" /></p>
			
					<h3>spinner</h3>
					<div class="line_box">
						<p><input class="spinner" type="text" value="1" title="수량입력" /></p>
						<br>
						<p><span class="inp_spinner"><input type="text" value="1" title="수량입력" readonly="readonly" /><button class="btn btn_plus">더하기</button><button class="btn btn_minus">빼기</button></span></p>
					</div>							
			
					<h2>탭메뉴</h2>
					<h3>tabmenu</h3>
					<div>
						<ul class="tabmenu">
							<li><a href="#">메뉴1</a></li>
							<li class="on"><a href="#">메뉴2</a></li>
							<li><a href="#">메뉴3</a></li>
						</ul>
						<br>
						<ul class="tabmenu tabMotion">
							<li><a href="#tabCon1">메뉴1</a></li>
							<li><a href="#tabCon2">메뉴2</a></li>
							<li><a href="#tabCon3">메뉴3</a></li>
							<li><a href="#tabCon4">메뉴4</a></li>
						</ul>
						<div id="tabCon1" class="tab_cont">탭내용1</div>
						<div id="tabCon2" class="tab_cont">탭내용2</div>
						<div id="tabCon3" class="tab_cont">탭내용3</div>
						<div id="tabCon4" class="tab_cont">탭내용4</div>
					</div>
			
					<h2>table</h2>
					<h3>table</h3>
					<div>
						<div class="list_search_wrap">
							<div class="list_search">
								<select title="검색조건선택">
									<option value="전체보기">전체보기</option>
									<option value="회원">회원</option>
									<option value="주문">주문</option>
									<option value="취소">취소</option>
									<option value="취소">취소</option>
									<option value="결제">결제</option>
									<option value="할인">할인</option>
								</select>
								<input type="text" title="검색내용입력" />
								<span class="btn">
									<a href="#" class="button">검색</a>
								</span>
							</div>
						</div>
						<div class="tbl_wrap">
							<table class="table tbl_hover td_bor_no">
								<caption>FAQ 정보</caption>
								<colgroup>
									<col style="width:10%" />
									<col style="width:20%" />
									<col />
									<col style="width:20%" />
									<col style="width:20%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">관리자 아이디</th>
										<th scope="col">브랜드</th>
										<th scope="col">관리자명</th>
										<th scope="col">권한</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>00000000</td>
										<td>어디무슨브랜드</td>
										<td>브랜드 담당자</td>
										<td>삼성동 매장 담당</td>
									</tr>
									
								</tbody>
							</table>
						</div>
						
						<div class="tbl_btn">
							<p class="f_right">
								<a href="#" class="button h30 w70 btn_yellow">등록</a>
							</p>
						</div>
					</div>
						
					<h3>table + tbl_hover &amp; checkbox</h3>
					<div>
						<table class="table tbl_hover">
							<caption>테이블 제목</caption>
							<colgroup>
								<col style="width:50px" />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">
										<label class="checkbox only">
											<input name="checkbox3" type="checkbox" />
											<span class="lbl"><span class="blind">모두선택</span></span>
										</label>
									</th>
									<th scope="col">분류</th>
									<th scope="col">분류</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th scope="row">합계</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<th scope="row">
										<label class="checkbox only">
											<input name="checkbox3" type="checkbox" />
											<span class="lbl"><span class="blind">선택</span></span>
										</label>
									</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
								<tr>
									<th scope="row">
										<label class="checkbox only">
											<input name="checkbox3" type="checkbox" />
											<span class="lbl"><span class="blind">선택</span></span>
										</label>									
									</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
								<tr>
									<th scope="row">
										<label class="checkbox only">
											<input name="checkbox3" type="checkbox" />
											<span class="lbl"><span class="blind">선택</span></span>
										</label>
									</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
							</tbody>
						</table>
					</div>
			
					<h3>table + left_tbl</h3>
					<div>
						<table class="table left_tbl">
							<caption>테이블 제목</caption>
							<colgroup>
								<col style="width:15%" />
								<col />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">분류</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
								<tr>
									<th scope="row">분류</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
								<tr>
									<th scope="row">분류</th>
									<td>내용</td>
									<td>내용</td>
								</tr>
							</tbody>
						</table>
					</div>
			
					<h3>table + left_tbl + form_tbl</h3>
					<div>
						<table class="table left_tbl form_tbl">
							<caption>테이블 제목</caption>
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
									<th scope="row"><b class="t_red">*</b> 라디오버튼</th>
									<td>
										<div class="inp_wid wid2">
											<label class="radio">
												<input name="radio" type="radio" checked="checked" />
												<span class="lbl">radio1</span>
											</label>
											<label class="radio">
												<input name="radio" type="radio" />
												<span class="lbl">radio2</span>
											</label>
										</div>
									</td>
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
			
					<h3>table + left_tbl</h3>
					<table class="table left_tbl">
						<caption>테이블 제목</caption>
						<colgroup>
							<col style="width:15%" />
							<col />
							<col style="width:15%" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목</th>
								<td colspan="3">제목텍스트 제목텍스트 제목텍스트 제목텍스트 제목텍스트</td>
							</tr>
							<tr>
								<th scope="row">작성일</th>
								<td>2014.11.02</td>
								<th scope="row">작성자</th>
								<td>관리자</td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3">
									<div class="view_cont">
										내용<br />
										내용<br />
										내용<br />
										내용<br />
										내용<br />
										내용<br />
										내용<br />
										내용<br />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					
					<h3>table + tbl_view</h3>
					<table class="table tbl_view">
						<caption>이벤트 상세</caption>
						<colgroup>
							<col>
							<col style="width:40%;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" colspan="2" class="tit">매주 금요일 50% SKT가 쏜다</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="date">기간 : 2014.05.25-2014.06.30</td>
								<td class="t_right">적용매장 : 전매장</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="view_cont">
										내용<br>
										내용<br>
										내용<br>
										내용<br>
										내용<br>
										내용<br>
										내용<br>
										내용<br>
									</div>
									<div class="btn_wrap view_btn"><a href="#" class="button btn_blk h35">쿠폰다운받기</a></div>
								</td>
							</tr>
						</tbody>
					</table>
					<h2>pagination</h2>
					
					<div class="t_center mt30">
						<ul class="pagination">
							<li class="disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
							<li class="disabled"><a href="#"><i class="fa fa-angle-left"></i></a></li>
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i></a></li>
							<li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
						</ul>
					</div>
					<h3>etc</h3>
					<div>
						<ul class="txt_list">
							<li>내용내용내용내용내용내용</li>
							<li>내용내용내용내용내용내용내용내용내용내용내용</li>
							<li>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</li>
						</ul>
						<br />
						<ul class="arr_list">
							<li>내용내용내용내용내용내용</li>
							<li>내용내용내용내용내용내용내용내용내용내용내용</li>
							<li>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</li>
						</ul>
					</div>
				
					<h2>popup</h2>
					<p>레이어팝업 호출시 pop_open 클래스 사용시: href값의 타켓팝업의 id 값 넣어줌
					<br /><br /> 
					<a href="#popup" class="button pop_open">팝업 열기</a></p>
					<br />
					<br />
					<p>
					레이어팝업 호출시 layerShow 함수 사용시
					<br /><br />
					<button class="button" onclick="layerShow('#popup')">팝업 열기</button></p>
			
					<h2>etc</h2>
			
					<h3>line_box</h3>
					<div class="line_box">
						line_box
					</div>
					<br />
					<div class="line_box bg_gray">
						bg_gray 적용 됨
					</div>
				</div>
			</section>