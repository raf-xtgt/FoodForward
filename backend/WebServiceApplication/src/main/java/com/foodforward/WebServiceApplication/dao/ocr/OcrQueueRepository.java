package com.foodforward.WebServiceApplication.dao.ocr;

import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.UUID;

@Repository
public interface OcrQueueRepository extends JpaRepository<ocr_processing_queue, UUID> {

    @Query("SELECT u FROM ocr_processing_queue u WHERE u.guid = :queueId")
    List<ocr_processing_queue> findByGuid(@Param("queueId") String queueId);

    // JPQL delete query to delete records by guid
    @Modifying
    @Transactional
    @Query("DELETE FROM ocr_processing_queue u WHERE u.guid = :queueId")
    void deleteByGuid(@Param("queueId") String queueId);


}
