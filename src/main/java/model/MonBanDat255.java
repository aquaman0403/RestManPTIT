package model;

import lombok.Data;

@Data
public class MonBanDat255 {
    private int id;
    private BanKhachDat255 banKhach;
    private MonAn255 food;
    private int quantity;
    private float totalPrice;
    public String note;
}
