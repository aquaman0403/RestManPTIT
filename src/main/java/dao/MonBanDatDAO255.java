package dao;

import model.MonBanDat255;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MonBanDatDAO255 extends DAO255 {
    private MonAnDAO255 foodDAO;
    private BanKhachDatDAO255 banKhachDatDAO;

    public MonBanDatDAO255() {
        super();
        this.foodDAO = new MonAnDAO255();
        this.banKhachDatDAO = new BanKhachDatDAO255();
    }

    // Display list of ordered food for a specific table
    public List<MonBanDat255> getOrderedFoodByTable(int reservationId) {
        List<MonBanDat255> orderedFoods = new ArrayList<>();
        String query = "SELECT * FROM OrderedFood255 WHERE reservationId = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, reservationId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                MonBanDat255 orderedFood = new MonBanDat255();
                orderedFood.setId(rs.getInt("id"));
                orderedFood.setQuantity(rs.getInt("quantity"));
                orderedFood.setTotalPrice(rs.getFloat("totalPrice"));
                orderedFood.setNote(rs.getString("note"));
                orderedFood.setFood(foodDAO.getFoodById(rs.getInt("foodId")));
                orderedFood.setBanKhach(banKhachDatDAO.getBookingById(rs.getInt("reservationId"))); // Fix typo here
                orderedFoods.add(orderedFood);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderedFoods;
    }

    // Update ordered food - adjust quantity and total price if the item already exists
    public void updateOrInsertOrderedFood(int reservationId, int foodId, int newQuantity, String note) {
        String queryCheck = "SELECT id, quantity, totalPrice FROM OrderedFood255 WHERE reservationId = ? AND foodId = ?";
        String queryUpdate = "UPDATE OrderedFood255 SET quantity = ?, totalPrice = ?, note = ? WHERE id = ?";
        String queryInsert = "INSERT INTO OrderedFood255 (reservationId, foodId, quantity, totalPrice, note) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement checkStmt = conn.prepareStatement(queryCheck)) {
            checkStmt.setInt(1, reservationId);
            checkStmt.setInt(2, foodId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int existingId = rs.getInt("id");
                int existingQuantity = rs.getInt("quantity");

                // Update quantity and total price
                int updatedQuantity = existingQuantity + newQuantity;
                float foodPrice = foodDAO.getFoodById(foodId).getPrice();
                float updatedTotalPrice = updatedQuantity * foodPrice;

                try (PreparedStatement updateStmt = conn.prepareStatement(queryUpdate)) {
                    updateStmt.setInt(1, updatedQuantity);
                    updateStmt.setFloat(2, updatedTotalPrice);
                    updateStmt.setString(3, note);
                    updateStmt.setInt(4, existingId);
                    updateStmt.executeUpdate();
                }
            } else {
                // Insert new ordered food
                float foodPrice = foodDAO.getFoodById(foodId).getPrice();
                float totalPrice = newQuantity * foodPrice;

                try (PreparedStatement insertStmt = conn.prepareStatement(queryInsert)) {
                    insertStmt.setInt(1, reservationId);
                    insertStmt.setInt(2, foodId);
                    insertStmt.setInt(3, newQuantity);
                    insertStmt.setFloat(4, totalPrice);
                    insertStmt.setString(5, note);
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete ordered food
    public void deleteOrderedFood(int orderedFoodId) {
        String query = "DELETE FROM OrderedFood255 WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, orderedFoodId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
