package model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class KhachHang255 extends ThanhVien255 {
    private int customerId;
}
