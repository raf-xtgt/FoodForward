package com.foodforward.WebServiceApplication.model.dto;

public class SaveRecipeDto {
    private final String recipeText;
    private final String userId;

    public SaveRecipeDto(String recipeText, String userId) {
        this.recipeText = recipeText;
        this.userId = userId;
    }

    public SaveRecipeDto() {
        this.recipeText = "";
        this.userId = "";
    }

    public String getRecipeText() {
        return recipeText;
    }

    public String getUserId() {
        return userId;
    }
}
