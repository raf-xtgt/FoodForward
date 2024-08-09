package com.foodforward.WebServiceApplication.service.auth;

import com.foodforward.WebServiceApplication.model.container.auth.AuthLoginType;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.dto.AuthDto;
import com.foodforward.WebServiceApplication.service.auth.helper.AuthHelperService;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.ResponseEntity;

import java.util.Optional;

public class GoogleAuthService {
    private static final Log log = LogFactory.getLog(GoogleAuthService.class);

    public Optional<AuthUserProfile> signUpWithGoogle(final AuthDto authDto){
        try {
            // Verify the Google ID token
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(authDto.getGoogleIdToken());
            String uid = decodedToken.getUid();

            // Check if user already exists
            UserRecord userRecord;
            try {
                userRecord = FirebaseAuth.getInstance().getUser(uid);
                ResponseEntity.ok("User already exists with UID: " + userRecord.getUid());
            } catch (FirebaseAuthException e) {
                // Create a new user if not exists
                UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                        .setUid(uid)
                        .setEmail(decodedToken.getEmail());

                userRecord = FirebaseAuth.getInstance().createUser(request);
                log.info("User signed up successfully with UID: " + userRecord.getUid());
                return Optional.of(new AuthHelperService().constructUserProfile(userRecord, AuthLoginType.GOOGLE_LOGIN));

            }
        } catch (Exception e) {
            log.error("Google sign up failed");
            e.printStackTrace();
        }
        return Optional.empty();
    }

}
