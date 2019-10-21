package com.my.utils;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class filter implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object user=request.getSession().getAttribute("user");
        if(user!=null){

            return true;
        }else {
            request.setAttribute("err","你还没登录！");
            request.getRequestDispatcher("/index.html").forward(request,response);
            return false;
        }

    }
}
