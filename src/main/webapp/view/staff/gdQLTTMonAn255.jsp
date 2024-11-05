<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Quản lý món ăn</title>
    <style>
        body {
            font-family: SF Pro Display, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-container {
            width: 30%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            font-family: SF Pro Display, sans-serif;
            margin: 10px auto;
            min-width: 120px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .logout-button {
            background-color: #f44336;
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .logout-button:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Quản lý thông tin món ăn</h2>
    <a href="${pageContext.request.contextPath}/view/staff/gdTimKiemMonAn255.jsp" class="button">Sửa thông tin món ăn</a>
</div>
</body>
</html>
