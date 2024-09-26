package com.foodforward.WebServiceApplication.service.recipe;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.service.auth.AuthService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import com.foodforward.WebServiceApplication.model.dto.RecipeDto;
import org.springframework.web.client.RestTemplate;

import java.util.Optional;


@Service
public class RecipeService {
    private final RestTemplate restTemplate = new RestTemplate();
    private static final Log log = LogFactory.getLog(AuthService.class);


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
}
