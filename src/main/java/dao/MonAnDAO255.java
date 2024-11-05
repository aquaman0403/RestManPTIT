package dao;

import model.MonAn255;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MonAnDAO255 extends DAO255 {
    public MonAnDAO255() {
        super();
    }

    public List<MonAn255> getAllFood(int pageIndex, int pageSize) {
        List<MonAn255> foodList = new ArrayList<>();
        String sql = "SELECT * FROM food255 LIMIT ?, ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (pageIndex - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MonAn255 food = new MonAn255();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setType(rs.getString("type"));
                food.setPrice(rs.getInt("price"));
                food.setStatus(rs.getString("status"));
                food.setDescription(rs.getString("description"));
                foodList.add(food);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return foodList;
    }

    public boolean updateFood(MonAn255 food) {
        String sql = "UPDATE food255 SET name = ?, type = ?, price = ?, status = ?, description = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, food.getName());
            ps.setString(2, food.getType());
            ps.setInt(3, food.getPrice());
            ps.setString(4, food.getStatus());
            ps.setString(5, food.getDescription());
            ps.setInt(6, food.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public int getTotalFoodCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM food255";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<MonAn255> getMonAn255(String input) {
        List<MonAn255> foodList = new ArrayList<>();
        String sql = "SELECT * FROM food255 WHERE name LIKE ? OR type LIKE ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + input + "%");
            ps.setString(2, "%" + input + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MonAn255 food = new MonAn255();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setType(rs.getString("type"));
                food.setPrice(rs.getInt("price"));
                food.setStatus(rs.getString("status"));
                food.setDescription(rs.getString("description"));
                foodList.add(food);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return foodList;
    }

    public MonAn255 getFoodById(int id) {
        MonAn255 food = null;
        String sql = "SELECT * FROM food255 WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                food = new MonAn255();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setType(rs.getString("type"));
                food.setPrice(rs.getInt("price"));
                food.setStatus(rs.getString("status"));
                food.setDescription(rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return food;
    }

}
