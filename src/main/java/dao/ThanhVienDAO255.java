package dao;

import model.ThanhVien255;
import model.HoTen255;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ThanhVienDAO255 extends DAO255 {

    public ThanhVienDAO255() {
        super();
    }

    public ThanhVien255 checkLogin(String username, String password) {
        ThanhVien255 member = null;
        String sql = "SELECT * FROM member255 WHERE username = ? AND password = ?"; // Truy vấn trực tiếp

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                member = new ThanhVien255();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setPassword(rs.getString("password"));
                member.setRole(rs.getString("role"));

                HoTen255 name = new HoTen255();
                name.setLastName(rs.getString("lastname"));
                name.setMiddleName(rs.getString("middlename"));
                name.setFirstName(rs.getString("firstname"));
                member.setName(name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return member;
    }
}
