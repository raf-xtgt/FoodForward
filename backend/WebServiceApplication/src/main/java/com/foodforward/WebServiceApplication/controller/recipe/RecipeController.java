package com.foodforward.WebServiceApplication.controller.recipe;

import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.dto.RecipeDto;
import com.foodforward.WebServiceApplication.service.fileReference.FileUploadService;
import com.foodforward.WebServiceApplication.service.recipe.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value ={ "food-forward/recipe" })
public class RecipeController {
    @Autowired
    private RecipeService recipeService;

    @PostMapping(value ="/get-suggestion", consumes = MediaType.APPLICATION_JSON_VALUE)
    public String create (@RequestBody final RecipeDto dto){
        recipeService.getRecipe(dto);
        return "Success";
    }

}
