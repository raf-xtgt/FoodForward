package com.foodforward.WebServiceApplication.controller.foodStock;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.service.foodStock.FoodStockService;
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
@RequestMapping(value = { "food-forward/food-stock" })
public class FoodStockController {
    @Autowired
    private FoodStockService service;

    @PostMapping(value ="/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> create(@RequestBody final FoodStock foodStockCont) {
        final Optional<FoodStock> cont = service.createFoodStock(foodStockCont);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<FoodStock> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Food stock creation failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PutMapping(value ="/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> update(@RequestBody final FoodStock foodStockCont) {
        final Optional<FoodStock> cont = service.updateFoodStock(foodStockCont);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<FoodStock> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Food stock update failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @GetMapping(value ="/read/{id}")
    public ResponseEntity<StreamingResponseBody> read(@PathVariable final String id) {
        final Optional<FoodStock> cont = service.getFoodStockById(id);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<FoodStock> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Food stock read failed");
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
        final Optional<List<FoodStock>> list = service.getAllFoodStockHdrs();

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<FoodStock>> apiResponse = new ApiResponse<>(200, list.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Food stock read failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @DeleteMapping(value ="/delete/{queueId}")
    public ResponseEntity<StreamingResponseBody> delete(@PathVariable final String queueId) {
        final Optional<String> cont = service.deleteFoodStock(queueId);

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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Food stock deletion failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

}
