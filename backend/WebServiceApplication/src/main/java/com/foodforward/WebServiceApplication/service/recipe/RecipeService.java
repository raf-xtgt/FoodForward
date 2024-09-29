package com.foodforward.WebServiceApplication.service.recipe;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.dao.recipe.RecipeRepository;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.container.recipe.RecipeContainer;
import com.foodforward.WebServiceApplication.model.databaseSchema.recipe.recipe_hdr;
import com.foodforward.WebServiceApplication.model.dto.SaveRecipeDto;
import com.foodforward.WebServiceApplication.service.auth.AuthService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import com.foodforward.WebServiceApplication.model.dto.RecipeDto;
import org.springframework.web.client.RestTemplate;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service
public class RecipeService {
    @Autowired
    private RecipeRepository dao;
    private final RestTemplate restTemplate = new RestTemplate();
    private static final Log log = LogFactory.getLog(AuthService.class);


    public Optional<RecipeContainer> createRecipe(final SaveRecipeDto recipeDto){
        final RecipeContainer recipe = constructRecipe(recipeDto);
        dao.save(recipe.getRecipe_hdr());
        log.info("Successfully created recipe");
        return Optional.of(recipe);
    }

    private RecipeContainer constructRecipe(final SaveRecipeDto recipeDto){
        recipe_hdr hdr = new recipe_hdr();
        hdr.setGuid(UUID.randomUUID().toString());
        hdr.setRecipe_text(recipeDto.getRecipeText());
        hdr.setCreated_by_user_guid(recipeDto.getUserId());
        hdr.setUpdated_by_user_guid(recipeDto.getUserId());
        hdr.setCreated_date(Instant.now().toString());
        hdr.setUpdated_date(Instant.now().toString());
        return new RecipeContainer(hdr);

    }

    public Optional<String> getRecipe(final RecipeDto recipeDto) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Convert the DTO into a JSON payload using ObjectMapper
        String jsonPayload = "";
        try {
            final ObjectMapper objectMapper = new ObjectMapper();
            jsonPayload = objectMapper.writeValueAsString(recipeDto);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Optional.empty(); // Return empty Optional if there's an error in conversion
        }

        // Wrap the payload and headers in an HttpEntity object
        HttpEntity<String> request = new HttpEntity<>(jsonPayload, headers);

        // Make the POST request and get the response as a string
        String response = restTemplate.postForObject("http://172.17.0.2:5000/suggest-recipe", request, String.class);
        log.info("Successfully generated recipe");

        return Optional.ofNullable(response);
    }

    public Optional<List<RecipeContainer>> getAllRecipes(){
        try{
            List<RecipeContainer> recipeList = dao.findAll().stream().map(RecipeContainer::new).toList();
            return Optional.of(recipeList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
