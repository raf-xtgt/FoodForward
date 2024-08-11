package com.foodforward.WebServiceApplication.processor.scheduler;


import com.google.cloud.vertexai.VertexAI;
import com.google.cloud.vertexai.api.GenerateContentResponse;
import com.google.cloud.vertexai.generativeai.ContentMaker;
import com.google.cloud.vertexai.generativeai.GenerativeModel;
import com.google.cloud.vertexai.generativeai.PartMaker;
import com.google.cloud.vertexai.generativeai.ResponseHandler;
import java.util.Base64;

public class MultimodalQuery {
    
    // Ask the model to recognise the brand associated with the logo image.
    public String multimodalQuery(String projectId, String location, String modelName,
                                         String dataImageBase64) throws Exception {
        // Initialize client that will be used to send requests. This client only needs
        // to be created once, and can be reused for multiple requests.
        try (VertexAI vertexAI = new VertexAI(projectId, location)) {
            String output;
            byte[] imageBytes = Base64.getDecoder().decode(dataImageBase64);

            GenerativeModel model = new GenerativeModel(modelName, vertexAI);
            GenerateContentResponse response = model.generateContent(
                    ContentMaker.fromMultiModalData(
                            "What is this image?",
                            PartMaker.fromMimeTypeAndData("image/png", imageBytes)
                    ));

            output = ResponseHandler.getText(response);
            return output;
        }
    }
}