<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BanKhachDatDAO255" %>
<%@ page import="model.BanKhachDat255" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.ThanhVien255" %>
<%
    ThanhVien255 customer = (ThanhVien255) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Bàn Đặt</title>
    <style>
        body {
            font-family: 'SF Pro Display', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"] {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="submit"] {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            max-width: 800px;
            border-collapse: collapse;
            margin: 20px auto;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f8f9fa;
            color: #333;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-results {
            color: #dc3545;
            font-weight: normal;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<h1>Tìm Bàn Đặt</h1>
<form action="gdTimBan255.jsp" method="post">
    <label for="searchTerm">Tên hoặc Số Điện Thoại:</label>
    <input type="text" id="searchTerm" name="searchTerm" required>
    <br>
    <input type="submit" value="Tìm Kiếm">
</form>
<button onclick="window.history.back()">Quay lại</button>
<%
    String searchTerm = request.getParameter("searchTerm");

    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
        BanKhachDatDAO255 dao = new BanKhachDatDAO255();
        List<BanKhachDat255> bookings = dao.getBanKhachDat255(searchTerm);

        if (bookings != null && !bookings.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
%>
<h2>Kết Quả Tìm Kiếm:</h2>
<table>
    <tr>
        <th>STT</th>
        <th>Tên Khách Hàng</th>
        <th>Số Điện Thoại</th>
        <th>Bàn</th>
        <th>Ngày Đặt</th>
        <th>Giờ Đặt</th>
        <th></th>
    </tr>
    <%
        int stt = 1;
        for (BanKhachDat255 booking : bookings) {
            String fullName = booking.getCustomer().getName().getLastName() + " " +
                    booking.getCustomer().getName().getMiddleName() + " " +
                    booking.getCustomer().getName().getFirstName();
            Timestamp timestamp = booking.getTimestamp();
            String date = timestamp != null ? dateFormat.format(timestamp) : "N/A";
            String time = timestamp != null ? timeFormat.format(timestamp) : "N/A";
    %>
    <tr>
        <td><%= stt++ %>
        </td>
        <td><%= fullName %>
        </td>
        <td><%= booking.getCustomer().getPhone() %>
        </td>
        <td><%= booking.getTable().getName() %>
        </td>
        <td><%= date %>
        </td>
        <td><%= time %>
        </td>
        <td><a href="gdXemBanDat255.jsp?bookingId=<%= booking.getId() %>">Đặt món</a></td>
    </tr>
    <%
        }
    %>
</table>
<%
} else {
%>
<h2 class="no-results">Không tìm thấy kết quả nào!</h2>
<%
        }
    }
%>
</body>
</html>