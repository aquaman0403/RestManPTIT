package model;

import lombok.Data;
import java.sql.Date;

@Data
public class ThanhVien255 {
    private int id;
    private String username;
    private String password;
    private HoTen255 name;
    private Date birthday;
    private DiaChi255 address;
    private String email;
    private String phone;
    private String role;
}
