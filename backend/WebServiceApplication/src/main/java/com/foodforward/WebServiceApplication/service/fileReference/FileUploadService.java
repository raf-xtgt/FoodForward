package com.foodforward.WebServiceApplication.service.fileReference;

import com.foodforward.WebServiceApplication.dao.fileReference.FileReferenceRepository;
import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.container.ocr.OCRProcessingQueue;
import com.foodforward.WebServiceApplication.model.container.recipe.RecipeContainer;
import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import com.foodforward.WebServiceApplication.service.auth.AuthService;
import com.foodforward.WebServiceApplication.service.ocr.OCRProcessingQueueService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.*;

@Service
public class FileUploadService {
    @Autowired
    private FileReferenceRepository fileRefDao;
    @Autowired
    private OCRProcessingQueueService ocrService;

    private static final Log log = LogFactory.getLog(AuthService.class);
    public void createReference(final FileStorageRef container){
        fileRefDao.save(container.getFile_storage_ref());
        log.info("Successfully uploaded file");
    }

    private FileStorageRef constructFileStorageRef(final String fileName,
                                                   final String imageString,
                                                   final String userId){
        file_storage_ref reference = new file_storage_ref();
        reference.setGuid(UUID.randomUUID().toString());
        reference.setFile_name(fileName);
        reference.setFile_string(imageString);
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
            // Generate a unique identifier for the file
            String fileName = "Receipt-" + ZonedDateTime.now().toLocalDateTime().toString();
            final String base64String = convertFileToBase64(file);
            final FileStorageRef ref = constructFileStorageRef(fileName, base64String, userId);
            final OCRProcessingQueue ocrQueue = new OCRProcessingQueueService().constructOCRQueueFromStorageRef(ref, base64String);
            createReference(ref);
            ocrService.createOcrQueue(ocrQueue);
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

    public Optional<List<FileStorageRef>> getAllScans(){
        try{
            List<FileStorageRef> scanList = fileRefDao.findAll().stream().map(FileStorageRef::new).toList();
            return Optional.of(scanList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
