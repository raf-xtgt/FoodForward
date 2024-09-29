package com.foodforward.WebServiceApplication.controller.recipe;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.container.recipe.RecipeContainer;
import com.foodforward.WebServiceApplication.model.dto.RecipeDto;
import com.foodforward.WebServiceApplication.model.dto.SaveRecipeDto;
import com.foodforward.WebServiceApplication.service.recipe.RecipeService;
import com.foodforward.WebServiceApplication.shared.apiResponse.model.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value ={ "food-forward/recipe" })
public class RecipeController {
    @Autowired
    private RecipeService recipeService;

    @PostMapping(value ="/save-recipe", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> storeRecipe(@RequestBody final SaveRecipeDto dto) {
        final Optional<RecipeContainer> cont = recipeService.createRecipe(dto);
        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<RecipeContainer> apiResponse = new ApiResponse<>(200, cont.get());
                    String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                    outputStream.write(jsonResponse.getBytes());
                } catch (IOException e) {
                    throw new RuntimeException("Error streaming response", e);
                }
            };
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(responseBody);
        } else {
            StreamingResponseBody errorResponse = outputStream -> {
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Recipe save failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PostMapping(value ="/get-suggestion", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> getSuggestion(@RequestBody final RecipeDto dto) {
        final Optional<String> cont = recipeService.getRecipe(dto);
        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<String> apiResponse = new ApiResponse<>(200, cont.get());
                    String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                    outputStream.write(jsonResponse.getBytes());
                } catch (IOException e) {
                    throw new RuntimeException("Error streaming response", e);
                }
            };
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(responseBody);
        } else {
            StreamingResponseBody errorResponse = outputStream -> {
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Recipe suggestion failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @GetMapping(value ="/read/all")
    public ResponseEntity<StreamingResponseBody> readAll() {
        final Optional<List<RecipeContainer>> list = recipeService.getAllRecipes();

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<RecipeContainer>> apiResponse = new ApiResponse<>(200, list.get());
                    String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                    outputStream.write(jsonResponse.getBytes());
                } catch (IOException e) {
                    throw new RuntimeException("Error streaming response", e);
                }
            };
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(responseBody);
        } else {
            StreamingResponseBody errorResponse = outputStream -> {
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Recipe read failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

}
