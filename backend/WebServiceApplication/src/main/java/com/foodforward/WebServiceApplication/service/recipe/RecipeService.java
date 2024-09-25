package com.foodforward.WebServiceApplication.service.recipe;

import com.foodforward.WebServiceApplication.service.auth.AuthService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import com.foodforward.WebServiceApplication.model.dto.RecipeDto;
import org.springframework.web.client.RestTemplate;


@Service
public class RecipeService {
    private final RestTemplate restTemplate = new RestTemplate();

    private static final Log log = LogFactory.getLog(AuthService.class);
    public void getRecipe(final RecipeDto recipeDto){
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Create the JSON payload
        String jsonPayload = "{\"items\":\"" + recipeDto.getItemList() + "\"}";
        // Wrap the payload and headers in an HttpEntity object
        HttpEntity<String> request = new HttpEntity<>(jsonPayload, headers);
        String response = restTemplate.postForObject("http://172.17.0.2:5000/suggest-recipe", request, String.class);
        log.info("Successfully uploaded file");
    }
}
