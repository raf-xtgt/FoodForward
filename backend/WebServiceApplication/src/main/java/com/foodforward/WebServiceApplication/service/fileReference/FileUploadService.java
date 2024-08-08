package com.foodforward.WebServiceApplication.service.fileUpload;

import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.FileStorageRef;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileUpload.file_storage_ref;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.UUID;

public class FileUploadService {

    private static final Log log = LogFactory.getLog(FileUploadService.class);

    public void create(final FileStorageRef container){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        final UUID fileGuid = UUID.randomUUID();
        ApiFuture<WriteResult> future = db.collection(file_storage_ref.getSchemaAlias()).document(fileGuid.toString()).set(container);
        log.info("Successfully uploaded file");
    }
}
