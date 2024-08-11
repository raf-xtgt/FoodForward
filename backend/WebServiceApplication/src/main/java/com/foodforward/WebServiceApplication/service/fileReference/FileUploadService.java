package com.foodforward.WebServiceApplication.service.fileReference;

import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import com.foodforward.WebServiceApplication.service.ocr.OCRProcessingQueueService;
import com.foodforward.WebServiceApplication.shared.constants.Config;
import com.foodforward.WebServiceApplication.shared.fileUpload.FileUploadUtils;
import com.google.cloud.firestore.Firestore;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.Base64;
import java.util.UUID;

public class FileUploadService {

    private static final Log log = LogFactory.getLog(FileUploadService.class);

    public void createReference(final FileStorageRef container){
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        db.collection(file_storage_ref.getSchemaAlias())
                .document(container.getFile_storage_ref().getGuid().toString()).set(container);
        log.info("Successfully uploaded file");
    }

    private FileStorageRef constructFileStorageRef(final String fileName,
                                                   final String fileUrl,
                                                   final String userId){
        file_storage_ref reference = new file_storage_ref();
        reference.setGuid(UUID.randomUUID().toString());
        reference.setFile_name(fileName);
        reference.setFile_url(fileUrl);
        reference.setCreated_date(Instant.now());
        reference.setUpdated_date(Instant.now());
        reference.setCreated_by_user_guid(userId);
        reference.setUpdated_by_user_guid(userId);
        return new FileStorageRef(reference);
    }

    public void uploadMultiFiles(final MultipartFile[] files, final String userId){
        Arrays.stream(files).forEach(f -> uploadFile(f, userId));
    }

    public void uploadFile(final MultipartFile file, final String userId){

        try{
            // upload the file to a custom bucket
            // get the file url ( a way to retrieve the file)
            Storage storage = new FileUploadUtils().getFirebaseStorageInstance();
            String bucketName = Config.BUCKET_NAME; // Replace with your Firebase storage bucket name
            Bucket bucket = storage.get(bucketName);

            // Generate a unique identifier for the file
            String fileName = Config.STORAGE_FOLDER + "Receipt-" + ZonedDateTime.now().toLocalDateTime().toString();

            // Upload file to Firebase Storage
            Blob blob = bucket.create(fileName, file.getInputStream(), file.getContentType());

            // Return the public URL to the file
            String fileUrl = blob.getMediaLink();
            final FileStorageRef ref = constructFileStorageRef(fileName, fileUrl, userId);
            final String base64String = convertFileToBase64(file);
            final OCRProcessingQueue ocrQueue = new OCRProcessingQueueService().constructOCRQueueFromStorageRef(ref, base64String);
            createReference(ref);
            new OCRProcessingQueueService().createOcrQueue(ocrQueue);
            // using a scheduler pass the file to an ocr and store the result in a queue table.
            // using another scheduler process the queue table to create the recipient document hdr/line and history
        }
        catch(Exception e){
            log.error("Upload failed");
            e.printStackTrace();
        }


    }

    public String convertFileToBase64(final MultipartFile file) {
        try {
            // Read the file into a byte array
            byte[] fileContent = file.getBytes();

            // Encode the byte array to Base64
            String base64String = Base64.getEncoder().encodeToString(fileContent);

            return base64String;
        } catch (IOException e) {
            e.printStackTrace();
            return null; // Return null if there's an error
        }
    }
}
