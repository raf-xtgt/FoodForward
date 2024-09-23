package com.foodforward.WebServiceApplication.model.dto;

import java.util.ArrayList;
import java.util.List;

public class ReceiptDataResponse {
    private final List<FoodRetrievalDto> result;

    public ReceiptDataResponse() {
        this.result = new ArrayList<>();
    }

    public ReceiptDataResponse(List<FoodRetrievalDto> result) {
        this.result = result;
    }

    public List<FoodRetrievalDto> getResult() {
        return result;
    }
}
