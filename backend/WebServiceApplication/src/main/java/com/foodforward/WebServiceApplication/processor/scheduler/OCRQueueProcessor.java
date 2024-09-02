package com.foodforward.WebServiceApplication.processor.scheduler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.foodforward.WebServiceApplication.model.dto.FoodRetrievalDto;
import com.foodforward.WebServiceApplication.service.foodStock.FoodStockService;
import com.foodforward.WebServiceApplication.service.ocr.OCRProcessingQueueService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.cloud.vertexai.VertexAI;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@Component
public class OCRQueueProcessor {
    private static final Log log = LogFactory.getLog(OCRQueueProcessor.class);
    String projectId = "foodforward-3c212";
    String location = "asia-southeast1";
    String modelName = "gemini-1.5-flash-001";
    VertexAI vertexAI = new VertexAI(projectId, location);

    //@Scheduled(fixedRate = 60000) // Run every minute
    public void processReceipts() {

        System.out.println("Processing receipts at: " + System.currentTimeMillis());
        List<OCRProcessingQueue> ocrQueues =  getQueues();
        try {
            for (OCRProcessingQueue ocrQueue : ocrQueues) {
                sendToGeminiApi(ocrQueue, vertexAI);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<OCRProcessingQueue> getQueues(){
        List<OCRProcessingQueue> queueList = new ArrayList<>();
        try{
            final Firestore db = new DatabaseConnectionService().getDbConnection();
            CollectionReference collection = db.collection(ocr_processing_queue.getSchemaAlias());
            ApiFuture<QuerySnapshot> snapShot = collection.get();
            queueList =  snapShot.get().getDocuments().stream()
                    .map(docToMap -> {
                        final Map<String, Object> mappedDoc = docToMap.getData();
                        return  new ObjectMapper().convertValue(mappedDoc, OCRProcessingQueue.class);

                    })
                    .toList();
        }
        catch(Exception e){
            log.error("Failed to retrieve the queues");
            e.printStackTrace();
        }
        return queueList;
    }

    public void sendToGeminiApi(final OCRProcessingQueue ocrQueue, VertexAI vertexAI){
        try{
            final ocr_processing_queue queue = ocrQueue.getOcr_processing_queue();
            final String userId = queue.getCreated_by_id();
            final String jsonString = new MultimodalQuery().multimodalQuery(vertexAI, modelName, queue.getBase64());
            mapAIResponse(jsonString, userId);
            new OCRProcessingQueueService().deleteOcrQueue(queue.getGuid());
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }
    public void mapAIResponse(final String jsonString, final String userId){
        try{
            Gson gson = new Gson();
            Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
            List<Map<String, Object>> list = gson.fromJson(jsonString, listType);

            // Print the list of maps
            for (Map<String, Object> map : list) {
                System.out.println(map);
                final FoodRetrievalDto dto = new ObjectMapper().convertValue(map, FoodRetrievalDto.class);
                final FoodStock stock = new FoodStockService().constructFoodStockFromDto(dto, userId);
                new FoodStockService().createFoodStock(stock);
            }
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }

}

