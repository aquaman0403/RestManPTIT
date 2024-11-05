package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO255 {
    public static Connection conn;
    public DAO255() {
        if (conn == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/mydatabase1?autoReconnect=true&useSSL=false";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            String dbUser = "root";
            String dbPass = "123456789";
            try {
                Class.forName(dbClass);
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

