package com.foodforward.WebServiceApplication.dao.recipe;

import com.foodforward.WebServiceApplication.model.databaseSchema.recipe.recipe_hdr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface RecipeRepository extends JpaRepository<recipe_hdr, UUID> {


}
