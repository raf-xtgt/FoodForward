package com.foodforward.WebServiceApplication.dao.foodStock;

import com.foodforward.WebServiceApplication.model.databaseSchema.foodStock.food_stock_hdr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Repository
public interface FoodStockHdrRepository extends JpaRepository<food_stock_hdr, UUID> {

    @Query("SELECT u FROM food_stock_hdr u WHERE u.guid = :foodStockId")
    List<food_stock_hdr> findByGuid(@Param("foodStockId") String foodStockId);

    @Modifying
    @Transactional
    @Query("DELETE FROM food_stock_hdr u WHERE u.guid = :foodStockId")
    void deleteByGuid(@Param("foodStockId") String foodStockId);

}
