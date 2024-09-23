package com.foodforward.WebServiceApplication.processor.scheduler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.foodforward.WebServiceApplication.model.dto.FoodRetrievalDto;
import com.foodforward.WebServiceApplication.model.dto.ReceiptDataResponse;
import com.foodforward.WebServiceApplication.service.foodStock.FoodStockService;
import com.foodforward.WebServiceApplication.service.ocr.OCRProcessingQueueService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.cloud.vertexai.VertexAI;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class OCRQueueProcessor {
    private static final Log log = LogFactory.getLog(OCRQueueProcessor.class);
    String projectId = "foodforward-3c212";
    String location = "asia-southeast1";
    String modelName = "gemini-1.5-flash-001";
    VertexAI vertexAI = new VertexAI(projectId, location);
    @Autowired
    private OCRProcessingQueueService ocrService;
    private final RestTemplate restTemplate = new RestTemplate();


    @Scheduled(fixedRate = 60000) // Run every minute
    public void processReceipts() {

        System.out.println("Processing receipts at: " + System.currentTimeMillis());
        List<ocr_processing_queue> ocrQueues = new ArrayList<>() ;
        if(ocrService.getAllOcrQueues().isPresent()){
            ocrQueues = ocrService.getAllOcrQueues().get();
        }
        try {
            for (ocr_processing_queue ocrQueue : ocrQueues) {
                final String jsonResponse = triggerGenAIOCR(ocrQueue);
                map2(jsonResponse);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String triggerGenAIOCR(final ocr_processing_queue queue){
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Create the JSON payload
        String jsonPayload = "{\"imageStr\":\"" + queue.getBase64() + "\"}";
        // Wrap the payload and headers in an HttpEntity object
        HttpEntity<String> request = new HttpEntity<>(jsonPayload, headers);
        String response = restTemplate.postForObject("http://172.17.0.2:5000/run-gen-ai-ocr", request, String.class);
//        String apiResponse =
//        String jsonString = response.replace("`", "");
//        jsonString = jsonString.replace("json", "");
//        jsonString = jsonString.replace("\n", "");
        return response;
    }


    public void mapResponse(final String jsonResp){
        try{
            final ObjectMapper objectMapper = new ObjectMapper();
            final ReceiptDataResponse resp = objectMapper.readValue(jsonResp, ReceiptDataResponse.class) ;
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }

    public void map2(final String jsonString){
        Gson gson = new Gson();

        // Define the type as Map<String, Object>
        Type mapType = new TypeToken<Map<String, Object>>() {}.getType();

        // Parse the JSON string into a Map
        Map<String, Object> jsonResp = gson.fromJson(jsonString, mapType);

        // Extract the 'result' field as a string
        String rawResult = (String) jsonResp.get("result");

        // Clean up the rawResult by removing the backticks and any other unwanted characters
        // You might need a more complex cleanup depending on the input
        String cleanedJson = rawResult.replace("```json", "").replace("```", "").trim();
        Type listType = new TypeToken<List<FoodRetrievalDto>>() {}.getType();
        List<FoodRetrievalDto> productList = gson.fromJson(cleanedJson, listType);

    }

    public void mapAIResponse(final String jsonString, final String userId){
        try{
            Gson gson = new Gson();
            Type listType = new TypeToken<Map<String, Object>>(){}.getType();
            Map<String, Object> jsonResp = gson.fromJson(jsonString, listType);
            String jsonStringFromMap = gson.toJson(jsonResp);
            ReceiptDataResponse resp = gson.fromJson(jsonStringFromMap, ReceiptDataResponse.class);
            log.info("hhs");
            // Print the list of maps
//            for (Map<String, Object> map : list) {
//                System.out.println(map);
//                final FoodRetrievalDto dto = new ObjectMapper().convertValue(map, FoodRetrievalDto.class);
//                final FoodStock stock = new FoodStockService().constructFoodStockFromDto(dto, userId);
//                new FoodStockService().createFoodStock(stock);
//            }
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }

}

