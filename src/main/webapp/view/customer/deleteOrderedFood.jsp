<!-- filepath: /d:/PTIT4/RestMan/src/main/webapp/deleteOrderedFood.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.MonBanDatDAO255" %>
<%@ page import="model.ThanhVien255" %>
<%
    ThanhVien255 customer = (ThanhVien255) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<%
    int orderedFoodId = Integer.parseInt(request.getParameter("orderedFoodId"));
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    MonBanDatDAO255 orderedFoodDAO = new MonBanDatDAO255();
    orderedFoodDAO.deleteOrderedFood(orderedFoodId);
    response.sendRedirect("gdXemBanDat255.jsp?bookingId=" + bookingId);
%>