package com.foodforward.WebServiceApplication.model.container.auth;

import com.foodforward.WebServiceApplication.model.databaseSchema.auth.user_profile;

public class AuthUserProfile {
    private final user_profile user_profile;

    public AuthUserProfile(user_profile user_profile) {
        this.user_profile = user_profile;
    }
    public AuthUserProfile() {
        this.user_profile = new user_profile();
    }

    public user_profile getUser_profile() {
        return user_profile;
    }
}
