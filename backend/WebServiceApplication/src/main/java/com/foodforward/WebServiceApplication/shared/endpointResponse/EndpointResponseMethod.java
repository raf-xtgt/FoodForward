package com.foodforward.WebServiceApplication.shared.endpointResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.shared.endpointResponse.model.EndpointResponseModel;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.util.Collection;

public interface EndpointResponseMethod {
//    static ResponseEntity<StreamingResponseBody> genericOKResponse(final Object response){
//        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(new EndpointResponseModel<>
//                ("OK RESPONSE", response, "Successful").asStreamingResponse());
//    }

}
