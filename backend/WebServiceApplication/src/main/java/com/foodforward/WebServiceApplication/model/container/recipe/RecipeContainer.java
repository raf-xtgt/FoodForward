package com.foodforward.WebServiceApplication.model.container.recipe;

import com.foodforward.WebServiceApplication.model.databaseSchema.recipe.recipe_hdr;

public class RecipeContainer {
    private final recipe_hdr recipe_hdr;

    public RecipeContainer(recipe_hdr recipe_hdr) {
        this.recipe_hdr = recipe_hdr;
    }
    public RecipeContainer() {
        this.recipe_hdr = new recipe_hdr();
    }

    public recipe_hdr getRecipe_hdr() {
        return recipe_hdr;
    }
}
