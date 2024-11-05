package model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class NVQuanLy255 extends NhanVien255 {
    private int managementStaffId;
}
