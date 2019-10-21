package com.my.utils;


import org.springframework.web.servlet.LocaleResolver;
import org.thymeleaf.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

public class ConfigurationAdapter implements LocaleResolver {

    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        Locale loc=null;
        String st=request.getParameter("login");
        if(!StringUtils.isEmpty(st)){
            String[] sts=st.split("_");
            loc=new Locale(sts[0],sts[1]);
        }else {
            loc=Locale.getDefault();
        }

        return loc;
    }

    @Override
    public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {

    }
}
