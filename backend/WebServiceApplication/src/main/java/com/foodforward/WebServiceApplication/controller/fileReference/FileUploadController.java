package com.foodforward.WebServiceApplication.controller.fileReference;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.fileReference.FileStorageRef;
import com.foodforward.WebServiceApplication.model.container.recipe.RecipeContainer;
import com.foodforward.WebServiceApplication.shared.apiResponse.model.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.foodforward.WebServiceApplication.service.fileReference.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

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

    @GetMapping(value ="/read/all")
    public ResponseEntity<StreamingResponseBody> readAll() {
        final Optional<List<FileStorageRef>> list = fileUploadService.getAllScans();

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<FileStorageRef>> apiResponse = new ApiResponse<>(200, list.get());
                    String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                    outputStream.write(jsonResponse.getBytes());
                } catch (IOException e) {
                    throw new RuntimeException("Error streaming response", e);
                }
            };
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(responseBody);
        } else {
            StreamingResponseBody errorResponse = outputStream -> {
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Scan read failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }
}
