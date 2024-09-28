package com.foodforward.WebServiceApplication.service.foodStock;

import com.foodforward.WebServiceApplication.dao.foodStock.FoodStockHdrRepository;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.databaseSchema.foodStock.food_stock_hdr;
import com.foodforward.WebServiceApplication.model.dto.FoodRetrievalDto;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class FoodStockService {
    @Autowired
    private FoodStockHdrRepository foodStockDao;
    private static final Log log = LogFactory.getLog(FoodStockService.class);

    public FoodStock constructFoodStockFromDto(final FoodRetrievalDto dto, final String userId){
        food_stock_hdr hdr =new food_stock_hdr();
        hdr.setGuid(UUID.randomUUID().toString());
        hdr.setName(dto.getName());
        hdr.setQuantity(dto.getQuantity());
        hdr.setUnit_price(dto.getUnit_price());
        hdr.setTxn_amt(dto.getPrice());
        hdr.setCreated_date(Instant.now().toString());
        hdr.setUpdated_date(Instant.now().toString());
        hdr.setCreated_by_id(userId);
        hdr.setUpdated_by_id(userId);
        return new FoodStock(hdr);
    }

    public Optional<FoodStock> createFoodStock(final FoodStock foodStock){
        foodStockDao.save(foodStock.getFood_stock_hdr());
        log.info("Successfully created food stock");
        return Optional.of(foodStock);
    }

    public Optional<FoodStock> updateFoodStock(final FoodStock foodStock){
        foodStockDao.save(foodStock.getFood_stock_hdr());
        log.info("Successfully updated food stock");
        return Optional.of(foodStock);
    }

    public Optional<FoodStock> getFoodStockById(final String foodStockId){
        try{
            return foodStockDao.findByGuid(foodStockId).stream().map(FoodStock::new).findFirst();
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<FoodStock>> getAllFoodStockHdrs(){
        try{
            List<FoodStock> foodStockList = foodStockDao.findAll().stream().map(FoodStock::new).toList();
            return Optional.of(foodStockList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<String> deleteFoodStock(final String foodStockId){
        try{
            foodStockDao.deleteByGuid(foodStockId);
            log.info("Successfully deleted food stock");
            return Optional.of(foodStockId);
        }
        catch(Exception e){
            log.error("OCR queue deletion");
            return Optional.empty();
        }
    }
}
