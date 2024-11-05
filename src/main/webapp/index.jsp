<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chính Khách Hàng</title>
    <style>
        body {
            font-family: SF Pro Display, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h1 {
            color: #333;
        }

        .menu {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            width: 300px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .menu a {
            padding: 10px 15px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
            width: 100%;
            box-sizing: border-box;
        }

        .menu a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h1>Chào Mừng Đến Nhà Hàng</h1>
<div class="menu">
    <a href="view/customer/gdTimBan255.jsp">Đặt Món Trực Tuyến</a>
</div>
</body>
</html>