<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MonAnDAO255" %>
<%@ page import="model.MonAn255" %>
<%@ page import="model.ThanhVien255" %>

<%
    ThanhVien255 staff = (ThanhVien255) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập nhật món ăn</title>
    <style>
        body {
            font-family: 'SF Pro Display', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 20px;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 24px;
        }

        .result-container {
            width: 50%;
            max-width: 500px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        p {
            margin: 15px 0;
            font-size: 18px;
            color: #555;
        }

        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            font-size: 18px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    String foodId = request.getParameter("id");
    String name = request.getParameter("name");
    String type = request.getParameter("type");
    int price = Integer.parseInt(request.getParameter("price"));
    String status = request.getParameter("status");
    String description = request.getParameter("description");

    MonAnDAO255 foodDAO = new MonAnDAO255();

    MonAn255 food = new MonAn255();
    food.setId(Integer.parseInt(foodId));
    food.setName(name);
    food.setType(type);
    food.setPrice(price);
    food.setStatus(status);
    food.setDescription(description);

    // Cập nhật thông tin món ăn
    boolean isUpdated = foodDAO.updateFood(food);
%>

<div class="result-container">
    <%
        if (isUpdated) {
    %>
    <h2>Cập nhật thành công!</h2>
    <p>Món ăn đã được cập nhật thành công.</p>
    <a href="${pageContext.request.contextPath}/view/staff/gdTimKiemMonAn255.jsp">Quay lại tìm kiếm</a>
    <%
    } else {
    %>
    <h2>Cập nhật không thành công!</h2>
    <p>Xin vui lòng thử lại.</p>
    <a href="${pageContext.request.contextPath}/view/staff/gdTimKiemMonAn255.jsp">Quay lại tìm kiếm</a>
    <%
        }
    %>
</div>
</body>
</html>
