package com.foodforward.WebServiceApplication.controller.fileUpload;

import com.foodforward.WebServiceApplication.model.container.FileStorageRef;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.foodforward.WebServiceApplication.service.fileUpload.*;

@RestController
@RequestMapping(value ={ "food-forward/upload-file" })
public class FileUploadController {

    public FileUploadService service;



    @PostMapping(value ="/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public String create (@RequestBody final FileStorageRef container){
        new FileUploadService().create(container);
        return "Success";
    }
}
