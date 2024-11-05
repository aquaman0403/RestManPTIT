<%@ page import="java.util.*, model.MonBanDat255, dao.MonBanDatDAO255" %>
<%@ page import="model.ThanhVien255" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ThanhVien255 customer = (ThanhVien255) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<%
    int reservationId = Integer.parseInt(request.getParameter("bookingId"));
    List<MonBanDat255> orderedFoods = (List<MonBanDat255>) session.getAttribute("orderedFoods");
    MonBanDatDAO255 orderedFoodDAO = new MonBanDatDAO255();

    if (orderedFoods != null) {
        for (MonBanDat255 orderedFood : orderedFoods) {
            orderedFoodDAO.updateOrInsertOrderedFood(reservationId, orderedFood.getFood().getId(), orderedFood.getQuantity(), orderedFood.getNote());
        }
        orderedFoods.clear();
        session.setAttribute("orderedFoods", orderedFoods);
    }
    response.sendRedirect("gdXemBanDat255.jsp?bookingId=" + reservationId);
%>