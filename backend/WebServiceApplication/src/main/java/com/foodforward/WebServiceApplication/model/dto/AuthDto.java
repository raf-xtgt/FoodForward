package com.foodforward.WebServiceApplication.model.dto;

public class AuthDto {
    private final String email;
    private final String password;
    private final String googleIdToken;

    public AuthDto(String email, String password, String googleIdToken) {
        this.email = email;
        this.password = password;
        this.googleIdToken = googleIdToken;
    }

    public AuthDto(String email, String password) {
        this.email = email;
        this.password = password;
        this.googleIdToken = null;
    }

    public AuthDto() {
        this.email = null;
        this.password = null;
        this.googleIdToken = null;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getGoogleIdToken() {
        return googleIdToken;
    }
}
