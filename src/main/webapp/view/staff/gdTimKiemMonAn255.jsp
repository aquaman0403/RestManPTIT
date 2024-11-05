<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MonAn255" %>
<%@ page import="dao.MonAnDAO255" %>
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
    <title>Tìm kiếm món ăn</title>
    <style>
        body {
            font-family: SF Pro Display, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }

        h2, h3 {
            text-align: center;
            color: #333;
        }

        form {
            text-align: center;
            margin: 20px 0;
        }

        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 30%;
            font-family: SF Pro Display, sans-serif;
        }

        input[type="submit"], button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
            transition: background-color 0.3s;
            font-family: SF Pro Display, sans-serif;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #0056b3;
        }

        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: white;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-results {
            text-align: center;
            color: #ff0000;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="header">
    <h2>Tìm kiếm món ăn</h2>
</div>

<form method="GET" action="${pageContext.request.contextPath}/view/staff/gdTimKiemMonAn255.jsp">
    <input type="text" name="name" placeholder="Nhập tên món ăn" required>
    <input type="submit" value="Tìm kiếm">
</form>

<div style="text-align: center; margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/view/staff/gdChinhNVQuanLy255.jsp">
        <button type="button">Quay về trang chủ</button>
    </a>
</div>

<%
    String foodName = request.getParameter("name");
    if (foodName != null && !foodName.isEmpty()) {
        MonAnDAO255 foodDAO = new MonAnDAO255();
        List<MonAn255> listFood = foodDAO.getMonAn255(foodName);

        if (listFood != null && !listFood.isEmpty()) {
%>
<h3>Kết quả tìm kiếm cho: <%= foodName %>
</h3>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên món ăn</th>
        <th>Loại</th>
        <th>Giá</th>
        <th>Trạng thái</th>
        <th>Mô tả</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (MonAn255 food : listFood) {
    %>
    <tr>
        <td><%= food.getId() %>
        </td>
        <td><%= food.getName() %>
        </td>
        <td><%= food.getType() %>
        </td>
        <td><%= food.getPrice() %>
        </td>
        <td><%= food.getStatus() %>
        </td>
        <td><%= food.getDescription() %>
        </td>
        <td><a href="${pageContext.request.contextPath}/view/staff/gdSuaTTMonAn255.jsp?id=<%= food.getId() %>">Sửa</a></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
} else {
%>
<p class="no-results">Không tìm thấy món ăn nào với tên: <%= foodName %>.</p>
<%
        }
    }
%>
</body>
</html>
