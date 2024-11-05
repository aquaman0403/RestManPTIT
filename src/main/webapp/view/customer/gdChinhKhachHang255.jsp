<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.ThanhVien255" %>
<%
    ThanhVien255 customer = (ThanhVien255) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giao Diện Chính Khách Hàng</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header {
            background-color: #343a40;
            color: white;
            padding: 20px;
            text-align: center;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .container {
            padding: 40px;
            max-width: 800px;
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 20px;
        }

        .welcome-message {
            font-size: 28px;
            margin-bottom: 30px;
            text-align: center;
            color: #343a40;
        }

        .menu-button, .logout-button {
            display: block;
            width: 100%;
            padding: 15px;
            text-align: center;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            margin: 10px 0;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .menu-button {
            background-color: #28a745;
            color: white;
        }

        .menu-button:hover {
            background-color: #218838;
        }

        .logout-button {
            background-color: #dc3545;
            color: white;
        }

        .logout-button:hover {
            background-color: #c82333;
        }
    </style>
    <script>
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function () {
            window.history.pushState(null, "", window.location.href);
        };
        // Prevent back navigation
        window.addEventListener('load', function () {
            if (window.history && window.history.pushState) {
                window.history.pushState(null, null, window.location.href);
                window.onpopstate = function () {
                    window.history.go(1);
                };
            }
        });
    </script>
</head>
<body>
<header class="header">
    <h1>Nhà Hàng PTIT</h1>
</header>
<main class="container">
    <div class="welcome-message">
        Chào
        mừng <%= customer.getName().getLastName() + " " + customer.getName().getMiddleName() + " " + customer.getName().getFirstName()%>
        đến với nhà hàng PTIT
    </div>
    <a href="${pageContext.request.contextPath}/view/customer/gdTimBan255.jsp" class="menu-button">Đặt Món Trực Tuyến</a>
    <a href="${pageContext.request.contextPath}/view/logout.jsp" class="logout-button">Đăng Xuất</a>
</main>
</body>
</html>
