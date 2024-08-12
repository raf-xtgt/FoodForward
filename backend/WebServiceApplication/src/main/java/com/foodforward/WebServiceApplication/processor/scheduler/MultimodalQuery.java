package com.foodforward.WebServiceApplication.processor.scheduler;


import com.google.cloud.vertexai.VertexAI;
import com.google.cloud.vertexai.api.GenerateContentResponse;
import com.google.cloud.vertexai.generativeai.ContentMaker;
import com.google.cloud.vertexai.generativeai.GenerativeModel;
import com.google.cloud.vertexai.generativeai.PartMaker;
import com.google.cloud.vertexai.generativeai.ResponseHandler;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.util.Base64;

public class MultimodalQuery {
    private static final Log log = LogFactory.getLog(MultimodalQuery.class);

    // Ask the model to recognise the brand associated with the logo image.
    public String multimodalQuery(VertexAI vertexAI, String modelName,
                                         String dataImageBase64) {
        String jsonString = "";
        // Initialize client that will be used to send requests. This client only needs
        // to be created once, and can be reused for multiple requests.
        try {

            byte[] imageBytes = Base64.getDecoder().decode(dataImageBase64);

            GenerativeModel model = new GenerativeModel(modelName, vertexAI);
            GenerateContentResponse response = model.generateContent(
                    ContentMaker.fromMultiModalData(
                            "Can you extract the items given in the image of the receipt and return to me as an" +
                                    " array of json objects. Each json object will be for each item.",
                            PartMaker.fromMimeTypeAndData("image/png", imageBytes)
                    ));

            jsonString = ResponseHandler.getText(response);
            jsonString = jsonString.replace("`", "");
            jsonString = jsonString.replace("json", "");
            return jsonString;
        }
        catch (Exception e){
            log.error("Error in ai "+ e.getMessage());
        }
        return jsonString;
    }
}