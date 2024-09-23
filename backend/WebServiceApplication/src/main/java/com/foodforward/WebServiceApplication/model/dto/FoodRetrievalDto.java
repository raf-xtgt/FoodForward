package com.foodforward.WebServiceApplication.model.dto;

public class FoodRetrievalDto {
    private final String name;
    private final String quantity;
    private final String unit;
    private final String unit_price;
    private final String price;

    public FoodRetrievalDto() {
        this.name = "";
        this.quantity = "";
        this.unit = "";
        this.unit_price = "";
        this.price = "";
    }

    public FoodRetrievalDto(String name, String quantity, String unit, String unit_price, String price) {
        this.name = name;
        this.quantity = quantity;
        this.unit = unit;
        this.unit_price = unit_price;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public String getQuantity() {
        return quantity;
    }

    public String getUnit() {
        return unit;
    }

    public String getUnit_price() {
        return unit_price;
    }

    public String getPrice() {
        return price;
    }
}
