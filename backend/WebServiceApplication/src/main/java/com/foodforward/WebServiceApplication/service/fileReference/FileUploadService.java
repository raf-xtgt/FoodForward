package com.foodforward.WebServiceApplication.service.fileReference;

import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.FileStorageRef;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import com.foodforward.WebServiceApplication.shared.constants.Config;
import com.foodforward.WebServiceApplication.shared.fileUpload.FileUploadUtils;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.UUID;

public class FileUploadService {

    private static final Log log = LogFactory.getLog(FileUploadService.class);

    public void createReference(final FileStorageRef container){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        final UUID fileGuid = UUID.randomUUID();
        ApiFuture<WriteResult> future = db.collection(file_storage_ref.getSchemaAlias()).document(fileGuid.toString()).set(container);
        log.info("Successfully uploaded file");
    }

    public void uploadMultiFiles(final MultipartFile[] files){
        Arrays.stream(files).forEach(this::uploadFile);
    }

    public void uploadFile(final MultipartFile file){

        try{
            // upload the file to a custom bucket
            // get the file url ( a way to retrieve the file)
            Storage storage = new FileUploadUtils().getFirebaseStorageInstance();
            String bucketName = Config.BUCKET_NAME; // Replace with your Firebase storage bucket name
            Bucket bucket = storage.get(bucketName);

            // Generate a unique identifier for the file
            String fileName = file.getOriginalFilename() + "-" + ZonedDateTime.now();

            // Upload file to Firebase Storage
            Blob blob = bucket.create(fileName, file.getInputStream(), file.getContentType());

            // Return the public URL to the file
            String fileUrl = blob.getMediaLink();
            final FileStorageRef ref = constructFileStorageRef(fileName, fileUrl);
            createReference(ref);
            // using a scheduler pass the file to an ocr and store the result in a queue table.
            // using another scheduler process the queue table to create the recipient document hdr/line and history
        }
        catch(Exception e){
            log.error("Upload failed");
            e.printStackTrace();
        }


    }

    private FileStorageRef constructFileStorageRef(final String fileName,
                                                   final String fileUrl){
        String fileHash = UUID.randomUUID().toString();
        file_storage_ref reference = new file_storage_ref();
        reference.setFile_hash(fileHash);
        reference.setFile_name(fileName);
        reference.setFile_url(fileUrl);
        reference.setCreated_date(Instant.now());
        reference.setUpdated_date(Instant.now());
        return new FileStorageRef(reference);


    }

}
