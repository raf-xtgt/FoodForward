package com.foodforward.WebServiceApplication.model.container.foodStock;
import com.foodforward.WebServiceApplication.model.databaseSchema.foodStock.food_stock_hdr;


public class FoodStock {
    private final food_stock_hdr food_stock_hdr;

    public FoodStock(food_stock_hdr food_stock_hdr) {
        this.food_stock_hdr = food_stock_hdr;
    }
    public FoodStock() {
        this.food_stock_hdr = new food_stock_hdr();
    }

    public food_stock_hdr getFood_stock_hdr() {
        return food_stock_hdr;
    }
}
