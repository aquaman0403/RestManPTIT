package model;

import lombok.Data;

import java.util.List;

@Data
public class Combo255 {
    private int id;
    private String name;
    private List<MonAn255> foods;
    private String type;
    private Float price;
    private String description;
}
