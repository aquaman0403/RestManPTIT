<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.ThanhVienDAO255, model.ThanhVien255" %>
<%
    // Thiết lập mã hóa cho phản hồi
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    ThanhVienDAO255 memberDAO = new ThanhVienDAO255();
    ThanhVien255 member = memberDAO.checkLogin(username, password);

    if (member != null) {
        if (member.getRole().equalsIgnoreCase("customer")) {
            session.setAttribute("customer", member);
            response.sendRedirect("customer/gdChinhKhachHang255.jsp");
        } else if (member.getRole().equalsIgnoreCase("staff")) {
            session.setAttribute("staff", member);
            response.sendRedirect("staff/gdChinhNVQuanLy255.jsp");
        }
    } else {
        String errorMessage = "Sai tên đăng nhập hoặc mật khẩu";
        response.sendRedirect("login.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
    }
%>
