<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>

<%
    // Invalidate the session
    session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }

    // Redirect to the login page after logout
    response.sendRedirect("index.html");
%>
