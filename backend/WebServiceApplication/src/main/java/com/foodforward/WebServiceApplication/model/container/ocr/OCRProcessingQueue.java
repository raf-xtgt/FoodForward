package com.foodforward.WebServiceApplication.model.container.ocr;

import com.foodforward.WebServiceApplication.model.databaseSchema.ocr.ocr_processing_queue;

public class OCRProcessingQueue {
    private final ocr_processing_queue ocr_processing_queue;

    public OCRProcessingQueue(ocr_processing_queue ocr_processing_queue) {
        this.ocr_processing_queue = ocr_processing_queue;
    }

    public OCRProcessingQueue() {
        this.ocr_processing_queue = new ocr_processing_queue();
    }

    public ocr_processing_queue getOcr_processing_queue() {
        return ocr_processing_queue;
    }
}
