<%@ page import="java.util.*, model.MonAn255, dao.MonAnDAO255, dao.MonBanDatDAO255" %>
<%@ page import="model.MonBanDat255" %>
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
    String searchQuery = request.getParameter("searchQuery");
    if (searchQuery == null) {
        searchQuery = "";
    }
    int reservationId = Integer.parseInt(request.getParameter("bookingId"));
    MonAnDAO255 foodDAO = new MonAnDAO255();
    List<MonAn255> searchResults = new ArrayList<>();
    List<MonBanDat255> orderedFoods = (List<MonBanDat255>) session.getAttribute("orderedFoods");

    if (orderedFoods == null) {
        orderedFoods = new ArrayList<>();
    }

    if (!searchQuery.isEmpty()) {
        searchResults = foodDAO.getMonAn255(searchQuery);
    }

    String action = request.getParameter("action");
    if ("add".equals(action)) {
        int foodId = Integer.parseInt(request.getParameter("foodId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String note = request.getParameter("note");

        boolean found = false;
        for (MonBanDat255 orderedFood : orderedFoods) {
            if (orderedFood.getFood().getId() == foodId) {
                orderedFood.setQuantity(orderedFood.getQuantity() + quantity);
                orderedFood.setTotalPrice(orderedFood.getQuantity() * orderedFood.getFood().getPrice());
                orderedFood.setNote(note);
                found = true;
                break;
            }
        }

        if (!found) {
            MonAn255 food = foodDAO.getFoodById(foodId);
            MonBanDat255 orderedFood = new MonBanDat255();
            orderedFood.setFood(food);
            orderedFood.setQuantity(quantity);
            orderedFood.setTotalPrice(quantity * food.getPrice());
            orderedFood.setNote(note);
            orderedFoods.add(orderedFood);
        }
        session.setAttribute("orderedFoods", orderedFoods);
    }

    if ("delete".equals(action)) {
        int orderedFoodId = Integer.parseInt(request.getParameter("orderedFoodId"));
        orderedFoods.removeIf(orderedFood -> orderedFood.getFood().getId() == orderedFoodId);
        session.setAttribute("orderedFoods", orderedFoods);
    }

    float totalAmount = 0;
    for (MonBanDat255 orderedFood : orderedFoods) {
        totalAmount += orderedFood.getTotalPrice();
    }
%>
<html>
<head>
    <title>Tìm Kiếm Món Ăn</title>
    <style>
        body {
            font-family: SF Pro Display, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }

        h1, h2, h3 {
            color: #333;
        }

        h1, h2 {
            font-size: 1.5em;
        }

        form {
            margin-bottom: 20px;
        }

        input[type="number"] {
            width: 50px;
        }

        input[type="text"], input[type="number"], input[type="submit"], button {
            font-family: SF Pro Display, sans-serif;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"], button {
            background-color: #5cb85c;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #4cae4c;
        }

        .container {
            display: flex;
            justify-content: space-around;
            gap: 20px;
        }

        .section {
            width: 47%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .total-amount {
            font-weight: bold;
            color: #d9534f;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .actions button {
            background-color: #0275d8;
        }

        .actions button:hover {
            background-color: #025aa5;
        }
    </style>
    <script>
        function confirmSave() {
            return alert("Bạn đã đặt món thành công");
        }

        function confirmCancel() {
            if (confirm("Bạn có chắc chắn muốn hủy đơn hàng không?")) {
                window.location.href = "gdXemBanDat255.jsp?bookingId=<%= reservationId %>";
                return false;
            }
            return false;
        }
    </script>
</head>
<body>
<h1>Tìm Kiếm Món Ăn</h1>
<form method="get">
    <input type="text" name="searchQuery" placeholder="Nhập tên món ăn" value="<%= searchQuery %>"/>
    <input type="hidden" name="bookingId" value="<%= reservationId %>"/>
    <button type="submit">Tìm Kiếm</button>
</form>

<div class="container">
    <div class="section">
        <h2>Kết Quả Tìm Kiếm</h2>
        <table>
            <tr>
                <th>Tên</th>
                <th>Loại</th>
                <th>Giá (VND)</th>
                <th>Trạng Thái</th>
                <th>Mô Tả</th>
                <th>Hành Động</th>
            </tr>
            <% for (MonAn255 food : searchResults) { %>
            <tr>
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
                <td>
                    <form method="post">
                        <input type="hidden" name="foodId" value="<%= food.getId() %>"/>
                        <input type="number" name="quantity" value="1" min="1"/>
                        <input type="text" name="note" placeholder="Ghi Chú"/>
                        <input type="hidden" name="action" value="add"/>
                        <input type="hidden" name="bookingId" value="<%= reservationId %>"/>
                        <button type="submit">Thêm món</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <div class="section">
        <h2>Danh sách món đặt</h2>
        <table>
            <tr>
                <th>Tên</th>
                <th>Số Lượng</th>
                <th>Tổng Giá (VND)</th>
                <th>Ghi Chú</th>
                <th>Hành Động</th>
            </tr>
            <% for (MonBanDat255 orderedFood : orderedFoods) { %>
            <tr>
                <td><%= orderedFood.getFood().getName() %>
                </td>
                <td><%= orderedFood.getQuantity() %>
                </td>
                <td><%= (int) orderedFood.getTotalPrice() %>
                </td>
                <td><%= orderedFood.getNote() %>
                </td>
                <td>
                    <form method="post">
                        <input type="hidden" name="orderedFoodId" value="<%= orderedFood.getFood().getId() %>"/>
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="bookingId" value="<%= reservationId %>"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <h3 class="total-amount">Tổng Số Tiền: <%= (int) totalAmount %> VND</h3>
        <div class="actions">
            <form method="post" action="doLuuDatMon255.jsp" onsubmit="return confirmSave();">
                <input type="hidden" name="bookingId" value="<%= reservationId %>"/>
                <button type="submit">Lưu Đơn Hàng</button>
            </form>
            <form method="post" onsubmit="return confirmCancel();">
                <input type="hidden" name="bookingId" value="<%= reservationId %>"/>
                <button type="submit">Hủy Đơn Hàng</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>