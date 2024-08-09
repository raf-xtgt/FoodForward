package com.foodforward.WebServiceApplication.service.auth;

import com.foodforward.WebServiceApplication.model.container.auth.AuthLoginType;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.databaseSchema.auth.user_profile;
import com.foodforward.WebServiceApplication.model.dto.AuthDto;
import com.foodforward.WebServiceApplication.service.auth.helper.AuthHelperService;
import com.foodforward.WebServiceApplication.shared.firestore.FirestoreService;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Optional;

public class AuthService {
    private static final Log log = LogFactory.getLog(AuthService.class);

    public Optional<AuthUserProfile> signUpWithEmailAndPassword(final AuthDto authDto){
        try{
            UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                    .setEmail(authDto.getEmail())
                    .setPassword(authDto.getPassword());
            UserRecord userRecord = FirebaseAuth.getInstance().createUser(request);
            return Optional.of(new AuthHelperService().constructUserProfile(userRecord, AuthLoginType.EMAIL_AND_PASSWORD_LOGIN));
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }


    public Optional<AuthUserProfile> loginWithEmailAndPassword(final AuthDto authDto) {
        try {
            // Sign in with email and password
            String customToken = FirebaseAuth.getInstance().createCustomToken(authDto.getEmail());
            // Return custom token
            return getUserProfile(customToken);
        } catch (FirebaseAuthException e) {
            e.printStackTrace();
            log.error("Login failed");
        }
        return Optional.empty();
    }

    public Optional<AuthUserProfile> getUserProfile(String token){
        try{
            final user_profile profile = new FirestoreService().getDocument(user_profile.getSchemaAlias(), token, user_profile.class);
            return Optional.of(new AuthUserProfile(profile));
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();


    }


}
