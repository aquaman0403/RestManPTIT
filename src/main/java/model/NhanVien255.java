package model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class NhanVien255 extends ThanhVien255 {
    private int staffID;
    private String position;
}
