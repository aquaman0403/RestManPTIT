<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.MonBanDatDAO255, model.MonBanDat255, model.BanKhachDat255" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dao.BanKhachDatDAO255" %>
<%@ page import="java.util.*" %>
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
    <title>Đặt Món Cho Bàn</title>
    <style>
        body {
            font-family: SF Pro Display, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        h1, h2 {
            color: #333;
        }

        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 4px 2px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }

        .btn-danger {
            background-color: #f44336;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa món ăn này không?");
        }
    </script>
</head>
<body>
<div class="container">
    <%
        String bookingIdStr = request.getParameter("bookingId");
        int bookingId = Integer.parseInt(bookingIdStr);

        BanKhachDatDAO255 bookingDAO = new BanKhachDatDAO255();
        BanKhachDat255 booking = bookingDAO.getBookingById(bookingId);

        String notification = (String) session.getAttribute("notification");
        if (notification != null) {
    %>
            <script type="text/javascript">
                alert("<%= notification %>");
            </script>
    <%
            session.removeAttribute("notification");
        }

        if (booking != null) {
            int reservationId = booking.getId();
    %>
    <h1>Đặt Món Cho Bàn <%= booking.getTable().getName() %>
    </h1>

    <h2>Thông Tin Khách Hàng</h2>
    <p>
        Tên: <%= booking.getCustomer().getName().getLastName() + " " + booking.getCustomer().getName().getMiddleName() + " " + booking.getCustomer().getName().getFirstName() %>
    </p>
    <p>Số Điện Thoại: <%= booking.getCustomer().getPhone() %>
    </p>
    <p>Ngày Đặt: <%= new SimpleDateFormat("dd-MM-yyyy").format(booking.getTimestamp()) %>
    </p>
    <p>Giờ Đặt: <%= new SimpleDateFormat("HH:mm:ss").format(booking.getTimestamp()) %>
    </p>
    <a class="btn" href="gdChonMon255.jsp?bookingId=<%= bookingId %>">Đặt Thêm Món Ăn</a>
    <h2>Danh Sách Món Ăn Đã Đặt</h2>
    <table>
        <tr>
            <th>STT</th>
            <th>Tên Món</th>
            <th>Số Lượng</th>
            <th>Tổng Tiền</th>
            <th>Ghi Chú</th>
            <th>Hành Động</th>
        </tr>
        <%
            MonBanDatDAO255 orderedFoodDAO = new MonBanDatDAO255();
            List<MonBanDat255> orderedFoods = orderedFoodDAO.getOrderedFoodByTable(reservationId);
            double totalAmount = 0;
            int serialNumber = 1;

            if (orderedFoods.isEmpty()) {
        %>
        <tr>
            <td colspan="6">Khách hàng chưa đặt món.</td>
        </tr>
        <%
        } else {
            for (MonBanDat255 orderedFood : orderedFoods) {
                totalAmount += orderedFood.getTotalPrice();
        %>
        <tr>
            <td><%= serialNumber++ %>
            </td>
            <td><%= orderedFood.getFood().getName() %>
            </td>
            <td><%= (int) orderedFood.getQuantity() %>
            </td>
            <td><%= (int) orderedFood.getTotalPrice() %> VND
            </td>
            <td><%= orderedFood.getNote() %>
            </td>
            <td>
                <form method="post" action="deleteOrderedFood.jsp" onsubmit="return confirmDelete();">
                    <input type="hidden" name="orderedFoodId" value="<%= orderedFood.getId() %>"/>
                    <input type="hidden" name="bookingId" value="<%= bookingId %>"/>
                    <button class="btn btn-danger" type="submit">Xóa</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
    <%
        if (!orderedFoods.isEmpty()) {
    %>
    <h3>Tổng Số Tiền: <%= (int) totalAmount %> VND</h3>
    <%
        }
    } else {
    %>
    <p>Không tìm thấy thông tin đặt bàn!</p>
    <%
        }
    %>
    <a class="btn" href="${pageContext.request.contextPath}/view/customer/gdChinhKhachHang255.jsp">Quay Về Trang Chủ</a>
</div>
</body>
</html>