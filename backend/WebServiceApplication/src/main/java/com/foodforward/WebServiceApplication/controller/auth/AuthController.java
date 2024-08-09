package com.foodforward.WebServiceApplication.controller.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.dto.AuthDto;
import com.foodforward.WebServiceApplication.service.auth.AuthService;
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

    @PostMapping(value ="/sign-in/email-and-password", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> signIn(@RequestBody final AuthDto authDto) {
        final Optional<AuthUserProfile> profileCont = new AuthService().signUpWithEmailAndPassword(authDto);

        if (profileCont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    String jsonResponse = new ObjectMapper().writeValueAsString(profileCont.get());
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
                String errorMessage = "Sign up via login and email failed";
                outputStream.write(errorMessage.getBytes());
            };
            return ResponseEntity.internalServerError()
                    .contentType(MediaType.TEXT_PLAIN)
                    .body(errorResponse);
        }
    }

    @PostMapping(value ="/login-in/email-and-password", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StreamingResponseBody> logIn(@RequestBody final AuthDto authDto) {
        final Optional<AuthUserProfile> profileCont = new AuthService().loginWithEmailAndPassword(authDto);

        if (profileCont.isPresent()) {
            StreamingResponseBody responseBody = outputStream -> {
                try {
                    String jsonResponse = new ObjectMapper().writeValueAsString(profileCont.get());
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
                String errorMessage = "Login via password and email failed";
                outputStream.write(errorMessage.getBytes());
            };
            return ResponseEntity.internalServerError()
                    .contentType(MediaType.TEXT_PLAIN)
                    .body(errorResponse);
        }
    }

}
