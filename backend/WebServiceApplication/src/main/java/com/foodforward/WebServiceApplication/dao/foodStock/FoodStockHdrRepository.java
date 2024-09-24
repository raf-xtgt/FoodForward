package com.foodforward.WebServiceApplication.dao.foodStock;

import com.foodforward.WebServiceApplication.model.databaseSchema.foodStock.food_stock_hdr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface FoodStockHdrRepository extends JpaRepository<food_stock_hdr, UUID> {
}
