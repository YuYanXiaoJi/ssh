package com.Filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

public class Filter extends StrutsPrepareAndExecuteFilter {
	
	 public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException {    
	        HttpServletRequest request = (HttpServletRequest) req;
	      //  HttpServletResponse response = (HttpServletResponse) res;
	        
	        request.setCharacterEncoding("utf-8");
	        
	     
	        String url = request.getRequestURI();    
	        if ("/City/ueditor/jsp/controller.jsp".equals(url)) {     
	            chain.doFilter(req, res);    
	        }
	        else if(url.equals("/City/null")){
	        	
	        }
	        else{    
	            super.doFilter(req, res, chain);    
	        }    
	    } 
}