package com.foodforward.WebServiceApplication.service.ocr;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import com.foodforward.WebServiceApplication.shared.firestore.FirestoreService;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.SetOptions;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public class OCRProcessingQueueService {
    private static final Log log = LogFactory.getLog(OCRProcessingQueueService.class);

    public Optional<OCRProcessingQueue>  createOcrQueue(final OCRProcessingQueue ocrQueue){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        db.collection(ocr_processing_queue.getSchemaAlias())
                .document(ocrQueue.getOcr_processing_queue().getGuid()).set(ocrQueue);
        log.info("Successfully created ocr queue");
        return Optional.of(ocrQueue);
    }

    public Optional<OCRProcessingQueue>  updateOcrQueue(final OCRProcessingQueue ocrQueue){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        db.collection(ocr_processing_queue.getSchemaAlias())
                .document(ocrQueue.getOcr_processing_queue().getGuid())
                .set(ocrQueue, SetOptions.merge());
        log.info("Successfully updated ocr queue");
        return Optional.of(ocrQueue);
    }

    public Optional<OCRProcessingQueue> getOcrQueue(final String ocrQueueId){
        try{
            final Firestore db = new DatabaseConnectionService().getDbConnection();
            final Map<String, Object> mappedDoc = new FirestoreService().getDocument(ocr_processing_queue.getSchemaAlias(),
                    ocrQueueId, ocr_processing_queue.class);
            final OCRProcessingQueue queue = new ObjectMapper().convertValue(mappedDoc, OCRProcessingQueue.class);
            return Optional.of(queue);

        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<String> deleteOcrQueue(final String ocrQueueId){
        try{
            final Firestore db = new DatabaseConnectionService().getDbConnection();
            db.collection(ocr_processing_queue.getSchemaAlias())
                    .document(ocrQueueId)
                    .delete().get();
            log.info("Successfully deleted ocr queue");
            return Optional.of(ocrQueueId);
        }
        catch(Exception e){
            log.error("OCR queue deletion");
            return Optional.empty();
        }
    }

    public OCRProcessingQueue constructOCRQueueFromStorageRef(final FileStorageRef fileStorageRef, final String imgString){
        final file_storage_ref ref = fileStorageRef.getFile_storage_ref();
        ocr_processing_queue ocrQueue = new ocr_processing_queue();
        ocrQueue.setGuid(UUID.randomUUID().toString());
        ocrQueue.setFile_ref_guid(ref.getGuid());
        ocrQueue.setFile_name(ref.getFile_name());
        ocrQueue.setFile_url(ref.getFile_url());
        ocrQueue.setBase64(imgString);
        ocrQueue.setCreated_date(Instant.now().toString());
        ocrQueue.setUpdated_date(Instant.now().toString());
        ocrQueue.setCreated_by_id(ref.getCreated_by_user_guid());
        ocrQueue.setUpdated_by_id(ref.getUpdated_by_user_guid());
        return new OCRProcessingQueue(ocrQueue);
    }
}
