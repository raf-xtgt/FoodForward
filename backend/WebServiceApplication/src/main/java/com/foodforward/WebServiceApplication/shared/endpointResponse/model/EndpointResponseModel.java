package com.foodforward.WebServiceApplication.shared.endpointResponse.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.util.Collection;

public final class EndpointResponseModel<T> {
    private final String code;
    private final T data;
    private final String message;

    public EndpointResponseModel() {
        this.code = null;
        this.data = null;
        this.message = null;
    }


    public EndpointResponseModel(String code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public T getData() {
        return data;
    }

    public String getMessage() {
        return message;
    }
}
