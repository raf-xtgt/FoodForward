package com.foodforward.WebServiceApplication.controller.fileReference;

import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import com.foodforward.WebServiceApplication.service.fileReference.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value ={ "food-forward/upload-image" })
public class FileUploadController {
    @Autowired
    private FileUploadService fileUploadService;

    @PostMapping(value ="/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public String create (@RequestBody final FileStorageRef container){
        fileUploadService.createReference(container);
        return "Success";
    }

    @PostMapping(value ="/multi/{userId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String multiImageUpload
            (@RequestParam final MultipartFile[] files,
             @PathVariable final String userId){
        fileUploadService.uploadMultiFiles(files, userId);
        return "Success";
    }
}
