package dao;

import model.BanKhachDat255;
import model.KhachHang255;
import model.HoTen255;
import model.BanAn255;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BanKhachDatDAO255 extends DAO255 {

    public BanKhachDatDAO255() {
        super();
    }

    public List<BanKhachDat255> getBanKhachDat255(String searchTerm) {
        List<BanKhachDat255> bookings = new ArrayList<>();
        String sql = "SELECT bkd.*, m.phone, m.lastName, m.middleName, m.firstName, t.name AS tableName " +
                "FROM BanKhachDat255 bkd " +
                "JOIN Customer255 c ON bkd.customerId = c.customerId " +
                "JOIN Member255 m ON c.customerId = m.id " +
                "JOIN Table255 t ON bkd.tableId = t.id " +
                "WHERE m.phone LIKE ? OR m.firstName LIKE ? OR m.middleName LIKE ? OR m.lastName LIKE ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            preparedStatement.setString(3, searchPattern);
            preparedStatement.setString(4, searchPattern);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                BanKhachDat255 booking = new BanKhachDat255();
                booking.setId(resultSet.getInt("id"));
                booking.setTimestamp(resultSet.getTimestamp("timestamp"));

                KhachHang255 customer = new KhachHang255();
                customer.setPhone(resultSet.getString("phone"));

                HoTen255 name = new HoTen255();
                name.setLastName(resultSet.getString("lastName"));
                name.setMiddleName(resultSet.getString("middleName"));
                name.setFirstName(resultSet.getString("firstName"));

                customer.setName(name);
                booking.setCustomer(customer);

                BanAn255 table = new BanAn255();
                table.setName(resultSet.getString("tableName"));
                booking.setTable(table);

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public BanKhachDat255 getBookingById(int bookingId) {
        BanKhachDat255 booking = null;
        String sql = "SELECT bkd.*, m.phone, m.lastName, m.middleName, m.firstName, t.name AS tableName " +
                "FROM BanKhachDat255 bkd " +
                "JOIN Customer255 c ON bkd.customerId = c.customerId " +
                "JOIN Member255 m ON c.customerId = m.id " +
                "JOIN Table255 t ON bkd.tableId = t.id " +
                "WHERE bkd.id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, bookingId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                booking = new BanKhachDat255();
                booking.setId(resultSet.getInt("id"));
                booking.setTimestamp(resultSet.getTimestamp("timestamp"));

                KhachHang255 customer = new KhachHang255();
                customer.setPhone(resultSet.getString("phone"));

                HoTen255 name = new HoTen255();
                name.setLastName(resultSet.getString("lastName"));
                name.setMiddleName(resultSet.getString("middleName"));
                name.setFirstName(resultSet.getString("firstName"));

                customer.setName(name);
                booking.setCustomer(customer);

                BanAn255 table = new BanAn255();
                table.setName(resultSet.getString("tableName"));
                booking.setTable(table);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return booking;
    }
}