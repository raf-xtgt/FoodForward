package com.foodforward.WebServiceApplication.service.auth.helper;

import com.foodforward.WebServiceApplication.model.container.auth.AuthLoginType;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.databaseSchema.auth.user_profile;
import com.google.firebase.auth.UserRecord;

import java.time.Instant;
import java.util.UUID;

public class AuthHelperService {
    public AuthUserProfile constructUserProfile(final UserRecord userRecord,
                                                 final AuthLoginType loginType){
        user_profile profile = new user_profile();
        profile.setGuid(UUID.fromString(userRecord.getUid()));
        profile.setLogin_type(loginType);
        profile.setUsername(userRecord.getDisplayName());
        profile.setCreated_date(Instant.now());
        profile.setUpdated_date(Instant.now());
        return new AuthUserProfile(profile);
    }
}
