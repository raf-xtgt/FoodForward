package com.foodforward.WebServiceApplication.service.foodStock;

import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.databaseSchema.food.food_stock_hdr;
import com.foodforward.WebServiceApplication.model.dto.FoodRetrievalDto;
import com.google.cloud.firestore.Firestore;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

public class FoodStockService {

    private static final Log log = LogFactory.getLog(FoodStockService.class);
    public FoodStock constructFoodStockFromDto(final FoodRetrievalDto dto, final String userId){
        food_stock_hdr hdr =new food_stock_hdr();
        hdr.setGuid(UUID.randomUUID().toString());
        hdr.setName(dto.getName());
        hdr.setQuantity(dto.getQuantity());
        hdr.setUnit_price(dto.getPricePerUnit());
        hdr.setTxn_amt(dto.getPrice());
        hdr.setCreated_date(Instant.now().toString());
        hdr.setUpdated_date(Instant.now().toString());
        hdr.setCreated_by_id(userId);
        hdr.setUpdated_by_id(userId);
        return new FoodStock(hdr);
    }

    public Optional<FoodStock> createFoodStock(final FoodStock foodStock){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        db.collection(food_stock_hdr.getSchemaAlias())
                .document(foodStock.getFood_stock_hdr().getGuid()).set(foodStock);
        log.info("Successfully created food stock");
        return Optional.of(foodStock);
    }
}
