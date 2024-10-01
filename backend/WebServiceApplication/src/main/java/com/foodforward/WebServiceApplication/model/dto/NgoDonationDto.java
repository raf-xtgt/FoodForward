package com.foodforward.WebServiceApplication.model.dto;


import java.util.ArrayList;
import java.util.List;

public class NgoDonationDto {
    private final String ngoGuid;
    private final String userId;
    private final List<String> foodStockGuids;

    public NgoDonationDto(String ngoGuid, String userId, List<String> foodStockGuids) {
        this.ngoGuid = ngoGuid;
        this.userId = userId;
        this.foodStockGuids = foodStockGuids;
    }

    public NgoDonationDto() {
        this.ngoGuid = "";
        this.userId = "";
        this.foodStockGuids = new ArrayList<>();
    }

    public String getNgoGuid() {
        return ngoGuid;
    }

    public List<String> getFoodStockGuids() {
        return foodStockGuids;
    }

    public String getUserId() {
        return userId;
    }
}
