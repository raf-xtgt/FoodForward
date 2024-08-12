package com.foodforward.WebServiceApplication.model.dto;

public class FoodRetrievalDto {
    private final String name;
    private final String quantity;
    private final String pricePerUnit;
    private final String price;

    public FoodRetrievalDto(String name, String quantity, String pricePerUnit, String price) {
        this.name = name;
        this.quantity = quantity;
        this.pricePerUnit = pricePerUnit;
        this.price = price;
    }

    public FoodRetrievalDto() {
        this.name = null;
        this.quantity = null;
        this.pricePerUnit = null;
        this.price = null;
    }

    public String getName() {
        return name;
    }

    public String getQuantity() {
        return quantity;
    }

    public String getPricePerUnit() {
        return pricePerUnit;
    }

    public String getPrice() {
        return price;
    }
}
