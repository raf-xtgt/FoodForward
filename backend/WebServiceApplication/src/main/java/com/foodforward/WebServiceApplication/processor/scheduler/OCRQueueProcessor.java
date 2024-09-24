package com.foodforward.WebServiceApplication.processor.scheduler;

import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.foodforward.WebServiceApplication.model.dto.FoodRetrievalDto;
import com.foodforward.WebServiceApplication.service.foodStock.FoodStockService;
import com.foodforward.WebServiceApplication.service.ocr.OCRProcessingQueueService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@Component
public class OCRQueueProcessor {
    private static final Log log = LogFactory.getLog(OCRQueueProcessor.class);
    @Autowired
    private OCRProcessingQueueService ocrService;
    @Autowired
    private FoodStockService foodStockService;
    private final RestTemplate restTemplate = new RestTemplate();


    @Scheduled(fixedRate = 600000) // Run every minute
    public void processReceipts() {

        System.out.println("Processing receipts at: " + System.currentTimeMillis());
        List<ocr_processing_queue> ocrQueues = new ArrayList<>() ;
        if(ocrService.getAllOcrQueues().isPresent()){
            ocrQueues = ocrService.getAllOcrQueues().get();
        }
        try {
            for (ocr_processing_queue ocrQueue : ocrQueues) {
                final String jsonResponse = triggerGenAIOCR(ocrQueue);
                final List<FoodRetrievalDto> itemList = mapAIResponse(jsonResponse);
                constructFoodStocks(itemList, ocrQueue);
                ocrService.deleteOcrQueue(ocrQueue.getGuid());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String triggerGenAIOCR(final ocr_processing_queue queue){
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Create the JSON payload
        String jsonPayload = "{\"imageStr\":\"" + queue.getBase64() + "\"}";
        // Wrap the payload and headers in an HttpEntity object
        HttpEntity<String> request = new HttpEntity<>(jsonPayload, headers);
        String response = restTemplate.postForObject("http://172.17.0.2:5000/run-gen-ai-ocr", request, String.class);
        return response;
    }


    private List<FoodRetrievalDto> mapAIResponse(final String jsonString){
        Gson gson = new Gson();
        // Define the type as Map<String, Object>
        Type mapType = new TypeToken<Map<String, Object>>() {}.getType();
        Map<String, Object> jsonResp = gson.fromJson(jsonString, mapType);
        String rawResult = (String) jsonResp.get("result");
        String cleanedJson = rawResult.replace("```json", "").replace("```", "").trim();
        Type listType = new TypeToken<List<FoodRetrievalDto>>() {}.getType();
        return gson.fromJson(cleanedJson, listType);
    }

    private void constructFoodStocks(final List<FoodRetrievalDto> prodList, final ocr_processing_queue ocrQueue){
        prodList.forEach(itemDto -> {
            final FoodStock fs = foodStockService.constructFoodStockFromDto(itemDto, ocrQueue.getCreated_by_id());
            foodStockService.createFoodStock(fs);
        });
    }

}

