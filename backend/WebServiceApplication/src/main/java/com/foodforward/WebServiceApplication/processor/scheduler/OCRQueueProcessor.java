package com.foodforward.WebServiceApplication.processor.scheduler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.foodforward.WebServiceApplication.service.fileReference.FileUploadService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class OCRQueueProcessor {
    private static final Log log = LogFactory.getLog(OCRQueueProcessor.class);
    private final String API_ENDPOINT = "https://api.gemini.com/ocr";
    private final String API_KEY = "AIzaSyCnyK16Z8AuD07Lta5sPbRf_vWjKW7Y318";

    @Scheduled(fixedRate = 60000) // Run every minute
    public void processReceipts() {
        System.out.println("Processing receipts at: " + System.currentTimeMillis());
        List<OCRProcessingQueue> ocrQueues =  getQueues();
        try {
            for (OCRProcessingQueue ocrQueue : ocrQueues) {
                String imageUrl = ocrQueue.getOcr_processing_queue().getFile_url();
                // Call method to process the image
                performOcr(imageUrl);
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

    public String performOcr(String imageUrl) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(imageUrl);
            HttpResponse response = httpClient.execute(request);

            HttpEntity entity = response.getEntity();
            if (entity != null) {
                byte[] imageBytes = EntityUtils.toByteArray(entity);
                sendToGeminiApi(imageBytes);
            }
        }
        catch(Exception e){
            log.error("Error doing ocr" + e.getMessage());
        }
        return "";
    }

    public void sendToGeminiApi(final byte[] imageBytes){
        try{
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            String ocrOutput = sendOCRRequest(base64Image);
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
    }

    private String sendOCRRequest(String base64Image) throws IOException, MalformedURLException {
        // Create the connection
        URL url = new URL(API_ENDPOINT);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Authorization", "Bearer " + API_KEY);
        connection.setDoOutput(true);

        // Create the JSON payload
        String jsonPayload = String.format("{\"image\": \"%s\"}", base64Image);

        // Send the request
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonPayload.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Get the response
        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            return response.toString();
        }
    }


}

