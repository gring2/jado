package org.scit.app.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ProjectInterceptor extends HandlerInterceptorAdapter {

@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("post...");
		
		HttpSession session = request.getSession();
		boolean isLeader = (Boolean) session.getAttribute("isLeader");
		String proNum = (String) session.getAttribute("proNum");
		
		if(isLeader) {
			System.out.println("isLeader true!!!!!");
			response.sendRedirect("gotoGroupLeader?proNum="+proNum);
		} else {
			System.out.println("isLeader false!!!!!");
			response.sendRedirect("gotoGroupMember?proNum="+proNum);
		}
		
	}

@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("pre....");
		
		return true;
	}
	
}
