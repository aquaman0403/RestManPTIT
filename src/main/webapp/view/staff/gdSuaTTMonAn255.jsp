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
    <title>Sửa món ăn</title>
    <style>
        body {
            font-family: 'SF Pro Display', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
            height: 100vh; /* Chiều cao toàn màn hình */
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-container {
            width: 50%;
            max-width: 500px; /* Giới hạn độ rộng form */
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            width: 30%; /* Chiều rộng cho nhãn */
            font-weight: bold;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea {
            width: 70%; /* Chiều rộng cho ô nhập */
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: 'SF Pro Display', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        textarea {
            resize: vertical;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .submit-button, .cancel-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'SF Pro Display', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            width: 48%; /* Đặt chiều rộng tự động */
        }

        .submit-button:hover, .cancel-button:hover {
            background-color: #0056b3;
        }

        .message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
<%
    String foodId = request.getParameter("id");
    MonAnDAO255 foodDAO = new MonAnDAO255();
    MonAn255 food = foodDAO.getFoodById(Integer.parseInt(foodId));

    if (food != null) {
%>
<div class="form-container">
    <h2>Sửa món ăn: <%= food.getName() %>
    </h2>
    <form action="${pageContext.request.contextPath}/view/staff/doLuuTTMonAn255.jsp" method="post">
        <input type="hidden" name="id" value="<%= food.getId() %>"/>

        <div class="form-group">
            <label>Tên món ăn:</label>
            <input type="text" name="name" value="<%= food.getName() %>" required/>
        </div>

        <div class="form-group">
            <label>Loại:</label>
            <input type="text" name="type" value="<%= food.getType() %>" required/>
        </div>

        <div class="form-group">
            <label>Giá:</label>
            <input type="number" name="price" value="<%= food.getPrice() %>" required/>
        </div>

        <div class="form-group">
            <label>Trạng thái:</label>
            <input type="text" name="status" value="<%= food.getStatus() %>" required/>
        </div>

        <div class="form-group">
            <label>Mô tả:</label>
            <textarea name="description" required><%= food.getDescription() %></textarea>
        </div>

        <div class="button-container">
            <input type="submit" value="Cập nhật" class="submit-button"/>
            <button type="button" class="cancel-button" onclick="window.location.href='${pageContext.request.contextPath}/view/staff/gdQLTTMonAn255.jsp'">Hủy</button>
        </div>
    </form>
</div>
<%
} else {
%>
<p class="message">Món ăn không tồn tại.</p>
<%
    }
%>
</body>
</html>
