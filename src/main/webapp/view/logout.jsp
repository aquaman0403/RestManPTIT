<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Xóa thông tin người dùng khỏi session
  session.invalidate(); // Xóa toàn bộ session
  response.sendRedirect("login.jsp"); // Chuyển hướng về trang đăng nhập
%>
