<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ecom.extra.util.Helper"%>
<%
			String path = request.getContextPath();
			com.ecom.core.util.WebBundle.includeJSFile(request, response);
			com.ecom.core.model.IUser user = Helper
					.getCurrentUserObject(request);
%>