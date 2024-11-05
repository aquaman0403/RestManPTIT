package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BanKhachDat255 {
    private int id;
    private KhachHang255 customer;
    private BanAn255 table;
    private Timestamp timestamp;
}
