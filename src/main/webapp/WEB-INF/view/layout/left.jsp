<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<nav id="gnb">
				<ul>
                    <li><a href="#">회원관리</a>
						<div>
							<ul>
								<li><a href="#"><span class="blind">회원관리</span> 고객리스트</a></li>
								<li><a href="#"><span class="blind">회원관리</span> 블랙리스트</a></li>
							</ul>
						</div>
                    </li>
                    <li><a href="#">직원관리</a>
						<div>
							<ul>
								<li><a href="#"><span class="blind">직원관리</span> 인사관리</a>
									<div>
										<ul>
											<li><a href="<%=cp%>/admin/list">리스트</a></li>
											<li><a href="<%=cp%>/admin/created">등록</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#"><span class="blind">직원관리</span> 근무관리</a>
									<div>
										<ul>
											<li><a href="#">출석관리</a></li>
											<li><a href="#">근무일지</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#"><span class="blind">직원관리</span> 급여관리</a></li>
							</ul>
						</div>
					</li>
                    <li><a href="#">여행관리</a>
                        <div>
							<ul>
								<li><a href="#"><span class="blind">여행관리</span> 고객리스트</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 블랙리스트 관리</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 지역관리</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 랜드마크 관리</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 통계 데이터</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 여행동료 관리</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 공지사항</a></li>
                                <li><a href="#"><span class="blind">여행관리</span> 이벤트</a></li>
							</ul>
						</div>
                    </li>
                    <li><a href="#">숙박관리</a>
                        <div>
							<ul>
								<li><a href="#"><span class="blind">숙박관리</span> 숙박관리</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 공지사항</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 문의사항</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 이벤트</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 고객관리</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 자주하는 질문</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 매출내역</a></li>
                                <li><a href="#"><span class="blind">숙박관리</span> 후기관리</a></li>
							</ul>
						</div>
                    </li>
                    <li><a href="#">쇼핑관리</a>
                        <div>
							<ul>
								<li><a href="#"><span class="blind">쇼핑관리</span> 제품관리</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 공지사항</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 문의사항</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 이벤트</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 고객관리</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 자주하는 질문</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 매출내역</a></li>
                                <li><a href="#"><span class="blind">쇼핑관리</span> 후기관리</a></li>
							</ul>
						</div>
                    </li>
				</ul>	
			</nav>