package com.foodforward.WebServiceApplication.controller.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.dto.AuthDto;
import com.foodforward.WebServiceApplication.service.auth.AuthService;
import com.foodforward.WebServiceApplication.service.test.TestService;
import com.foodforward.WebServiceApplication.shared.apiResponse.model.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.io.IOException;
import java.util.Optional;


@RestController
@RequestMapping(value = { "food-forward/auth" })
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping(value ="/sign-in/email-and-password", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> signIn(@RequestBody final AuthDto authDto) {
        final Optional<AuthUserProfile> profileCont = authService.signUpWithEmailAndPassword(authDto);

        if (profileCont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<AuthUserProfile> apiResponse = new ApiResponse<>(200, profileCont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Sign up via login and email failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PostMapping(value ="/login/email-and-password", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> logIn(@RequestBody final AuthDto authDto) {
        final Optional<AuthUserProfile> profileCont = authService.loginWithEmailAndPassword(authDto);

        if (profileCont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    ApiResponse<AuthUserProfile> apiResponse = new ApiResponse<>(200, profileCont.get());
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
                ApiResponse<String> apiResponse = new ApiResponse<>(500, "Login via login and email failed");
                String jsonResponse = new ObjectMapper().writeValueAsString(apiResponse);
                outputStream.write(jsonResponse.getBytes());
            };
            return ResponseEntity.status(500)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

}
