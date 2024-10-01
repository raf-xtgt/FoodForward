package com.foodforward.WebServiceApplication.controller.ngo;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoHdrContainer;
import com.foodforward.WebServiceApplication.model.dto.NgoDto;
import com.foodforward.WebServiceApplication.service.ngo.NgoHdrService;
import com.foodforward.WebServiceApplication.shared.apiResponse.model.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = { "food-forward/ngo" })
public class NgoHdrController {
    @Autowired
    private NgoHdrService service;

    @PostMapping(value ="/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> create(@RequestBody final NgoDto dto) {
        final Optional<NgoHdrContainer> cont = service.createNgoHdrContainer(dto);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoHdrContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Ngo Hdr creation failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PutMapping(value ="/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> update(@RequestBody final NgoHdrContainer foodStockCont) {
        final Optional<NgoHdrContainer> cont = service.updateNgoHdrContainer(foodStockCont);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoHdrContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Ngo Hdr update failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @GetMapping(value ="/read/{id}")
    public ResponseEntity<StreamingResponseBody> read(@PathVariable final String id) {
        final Optional<NgoHdrContainer> cont = service.getNgoHdrContainerById(id);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoHdrContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Ngo Hdr read failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @GetMapping(value ="/read/all")
    public ResponseEntity<StreamingResponseBody> readAll() {
        final Optional<List<NgoHdrContainer>> list = service.getAllNgoHdrContainerHdrs();

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<NgoHdrContainer>> apiResponse = new ApiResponse<>(200, list.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Ngo Hdr read failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @DeleteMapping(value ="/delete/{id}")
    public ResponseEntity<StreamingResponseBody> delete(@PathVariable final String queueId) {
        final Optional<String> cont = service.deleteNgoHdrContainer(queueId);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<String> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Ngo Hdr deletion failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

}
