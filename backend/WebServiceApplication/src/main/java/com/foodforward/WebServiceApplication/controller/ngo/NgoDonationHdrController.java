package com.foodforward.WebServiceApplication.controller.ngo;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoDonationContainer;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoDonationHdrContainer;
import com.foodforward.WebServiceApplication.model.dto.NgoDonationDto;
import com.foodforward.WebServiceApplication.service.ngo.NgoDonationHdrService;
import com.foodforward.WebServiceApplication.service.ngo.NgoDonationService;
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
@RequestMapping(value = { "food-forward/ngo-donation" })
public class NgoDonationHdrController {
    @Autowired
    private NgoDonationHdrService service;
    @Autowired
    private NgoDonationService donationService;

    @PostMapping(value ="/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> create(@RequestBody final NgoDonationDto dto) {
        final Optional<NgoDonationContainer> cont = donationService.createDonation(dto);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoDonationContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Donation creation failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PutMapping(value ="/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> update(@RequestBody final NgoDonationHdrContainer foodStockCont) {
        final Optional<NgoDonationHdrContainer> cont = service.updateNgoDonationHdrContainer(foodStockCont);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoDonationHdrContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
        final Optional<NgoDonationHdrContainer> cont = service.getNgoDonationHdrContainerById(id);

        if (cont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<NgoDonationHdrContainer> apiResponse = new ApiResponse<>(200, cont.get());
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
        final Optional<List<NgoDonationHdrContainer>> list = service.getAllNgoDonationHdrContainerHdrs();

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<NgoDonationHdrContainer>> apiResponse = new ApiResponse<>(200, list.get());
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

    @GetMapping(value ="/read/all/{ngoId}")
    public ResponseEntity<StreamingResponseBody> readByNgoId(@PathVariable final String id) {
        final Optional<List<NgoDonationHdrContainer>> list = service.getNgoDonationsByNgoId(id);

        if (list.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<List<NgoDonationHdrContainer>> apiResponse = new ApiResponse<>(200, list.get());
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
        final Optional<String> cont = service.deleteNgoDonationHdrContainer(queueId);

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
