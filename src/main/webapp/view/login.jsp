<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Nhập</title>
    <style>
        body {
            font-family: 'SF Pro Display', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-container {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .input-field {
            font-family: SF Pro Display, sans-serif;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            text-align: center;
            margin: 10px 0;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Đăng Nhập</h2>
    <%
        String errorMessage = request.getParameter("error");
        if (errorMessage != null) {
    %>
    <div class="error-message"><%= errorMessage %></div>
    <%
        }
    %>
    <form action="${pageContext.request.contextPath}/view/doLogin.jsp" method="post">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" class="input-field" required/>
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" class="input-field" required/>
        <input type="submit" value="Đăng Nhập" class="button"/>
    </form>
</div>
</body>
</html>
