package com.foodforward.WebServiceApplication.processor.scheduler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.*;

@Component
public class OCRQueueProcessor {
    private static final Log log = LogFactory.getLog(OCRQueueProcessor.class);
    String projectId = "foodforward-3c212";
    String location = "asia-southeast1";
    String modelName = "gemini-1.5-flash-001";


    @Scheduled(fixedRate = 60000) // Run every minute
    public void processReceipts() {
        System.out.println("Processing receipts at: " + System.currentTimeMillis());
        List<OCRProcessingQueue> ocrQueues =  getQueues();
        try {
            for (OCRProcessingQueue ocrQueue : ocrQueues) {
                String imageBase64 = ocrQueue.getOcr_processing_queue().getBase64();
                // Call method to process the image
                sendToGeminiApi(imageBase64);
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

    public void sendToGeminiApi(final String base64Image){
        try{
            new MultimodalQuery().multimodalQuery(projectId, location, modelName, base64Image);
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }

}

