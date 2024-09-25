package com.foodforward.WebServiceApplication.model.dto;

import java.util.ArrayList;
import java.util.List;

public class RecipeDto {
    private final List<String> itemList;

    public RecipeDto(List<String> itemList) {
        this.itemList = itemList;
    }

    public RecipeDto() {
        this.itemList = new ArrayList<>();
    }

    public List<String> getItemList() {
        return itemList;
    }
}
