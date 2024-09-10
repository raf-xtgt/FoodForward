package com.foodforward.WebServiceApplication.service.ocr;

import com.foodforward.WebServiceApplication.dao.ocr.OcrQueueRepository;
import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class OCRProcessingQueueService {
    @Autowired
    private OcrQueueRepository ocrDao;
    private static final Log log = LogFactory.getLog(OCRProcessingQueueService.class);

    public Optional<OCRProcessingQueue>  createOcrQueue(final OCRProcessingQueue ocrQueue){
        ocrDao.save(ocrQueue.getOcr_processing_queue());
        log.info("Successfully created ocr queue");
        return Optional.of(ocrQueue);
    }

    public Optional<OCRProcessingQueue>  updateOcrQueue(final OCRProcessingQueue ocrQueue){
        ocrDao.save(ocrQueue.getOcr_processing_queue());
        log.info("Successfully updated ocr queue");
        return Optional.of(ocrQueue);
    }

    public Optional<OCRProcessingQueue> getOcrQueue(final String ocrQueueId){
        try{
            return ocrDao.findByGuid(ocrQueueId).stream().map(OCRProcessingQueue::new).findFirst();
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<String> deleteOcrQueue(final String ocrQueueId){
        try{
            ocrDao.deleteByGuid(ocrQueueId);
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
        ocrQueue.setBase64(imgString);
        ocrQueue.setCreated_date(Instant.now().toString());
        ocrQueue.setUpdated_date(Instant.now().toString());
        ocrQueue.setCreated_by_id(ref.getCreated_by_user_guid());
        ocrQueue.setUpdated_by_id(ref.getUpdated_by_user_guid());
        return new OCRProcessingQueue(ocrQueue);
    }
}
