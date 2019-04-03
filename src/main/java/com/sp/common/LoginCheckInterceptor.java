package com.sp.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sp.admin.AdminSessionInfo;


public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
	private final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	//Ajax인지 아닌지 확인 메서드
	private boolean isAjaxRequest(HttpServletRequest req) {
		//AJAX 인경우 헤더에  AJAX=true 라는 값을 전송해서 확인함
		String header = req.getHeader("AJAX");
		return header != null && header.equals("true");
	}
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//클라이언트의 요청이 컨트롤러에 도착하기 전에 호출
		//false를 리턴하면 HandlerInterceptor 또는 컨트롤러를 실행하지 않고 요청 종료
		boolean flag = true;
		
		try {
			HttpSession session = request.getSession();
			AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
			
			String cp = request.getContextPath();
			String uri = request.getRequestURI();
			String queryString = request.getQueryString();
			
			if(info == null) {
				flag = false;
				
				if(isAjaxRequest(request)) {
					response.sendError(403); //AJAX인 경우 상태코드 403을 넘김
				} else {
					if(uri.indexOf(cp)==0) //redirect시 context주소는 빼줘야한다.
						uri=uri.substring(request.getContextPath().length());
					if(queryString!=null) {
						uri+="?"+queryString;
					}
					
					session.setAttribute("preLoginURI", uri);
					response.sendRedirect(cp+"/admin/login");
				}
			}
		}catch (Exception e) {
			logger.error("pre: "+e.toString());
		}
		
		return flag;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 컨트롤러의 요청을 처리한 후에 호출. 컨트롤러 실행 중 예외가 발생하면 실행하지 않음
		
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 클라이언트 요청을 처리한 후 , 즉 뷰를 통해 클라이언트에 응답을 전송한 뒤에 실행
		// 컨트롤러 처리중 또는 뷰를 생성하는 과정에서 예외가 발생해도 실행
		super.afterCompletion(request, response, handler, ex);
	}
}
