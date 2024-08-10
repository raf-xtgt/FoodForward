package com.foodforward.WebServiceApplication.model.dto;

public class AuthDto {
    private final String email;
    private final String password;
    private final String userId;

    public AuthDto(String email, String password, String googleIdToken, String userId) {
        this.email = email;
        this.password = password;
        this.userId = userId;
    }

    public AuthDto(String email, String password, String accessToken) {
        this.email = email;
        this.password = password;
        this.userId = accessToken;
    }

    public AuthDto(String email, String password) {
        this.email = email;
        this.password = password;
        this.userId = null;
    }

    public AuthDto(String accessToken) {
        this.userId = accessToken;
        this.email = null;
        this.password = null;
    }
    public AuthDto() {
        this.userId = null;
        this.email = null;
        this.password = null;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getUserId() {
        return userId;
    }
}
