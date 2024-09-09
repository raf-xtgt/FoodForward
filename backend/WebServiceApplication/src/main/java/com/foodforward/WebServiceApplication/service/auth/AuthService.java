package com.foodforward.WebServiceApplication.service.auth;

import com.foodforward.WebServiceApplication.model.container.auth.AuthLoginType;
import com.foodforward.WebServiceApplication.model.container.auth.AuthUserProfile;
import com.foodforward.WebServiceApplication.model.databaseSchema.auth.user_profile;
import com.foodforward.WebServiceApplication.model.dto.AuthDto;
import com.foodforward.WebServiceApplication.dao.AuthRepository;
import com.foodforward.WebServiceApplication.service.auth.helper.AuthHelperService;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class AuthService {
    @Autowired
    private AuthRepository authDao;
    private static final Log log = LogFactory.getLog(AuthService.class);

    public void createUserProfile(final AuthUserProfile container){
        authDao.save(container.getUser_profile());
        log.info("Successfully created profile");
    }
    public void updateUserProfile(final AuthUserProfile container){
        authDao.save(container.getUser_profile());
        log.info("Successfully created profile");
    }

    public Optional<AuthUserProfile> signUpWithEmailAndPassword(final AuthDto authDto){
        try{
            UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                    .setEmail(authDto.getEmail())
                    .setPassword(authDto.getPassword());
            UserRecord userRecord = FirebaseAuth.getInstance().createUser(request);
            String customToken = FirebaseAuth.getInstance().createCustomToken(authDto.getEmail());
            final AuthUserProfile authCont = new AuthHelperService().constructUserProfile(userRecord,
                    AuthLoginType.EMAIL_AND_PASSWORD_LOGIN, customToken);
            createUserProfile(authCont);
            return Optional.of(authCont);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }


    public Optional<AuthUserProfile> loginWithEmailAndPassword(final AuthDto authDto) {
        try {
            // Get custom token
            String customToken = FirebaseAuth.getInstance().createCustomToken(authDto.getEmail());
            // Return custom token
            final Optional<AuthUserProfile> profile = getUserProfile(authDto.getUserId());
            if (profile.isPresent()){
                profile.get().getUser_profile().setAccess_token(customToken);
                updateUserProfile(profile.get());
            }
            return profile;
        } catch (FirebaseAuthException e) {
            e.printStackTrace();
            log.error("Login failed");
        }
        return Optional.empty();
    }

    public Optional<AuthUserProfile> getUserProfile(String userId){
        try{
            final Optional<user_profile> userProfile = getProfileById(userId);
            if(userProfile.isPresent()){
                return Optional.of(new AuthUserProfile(userProfile.get()));
            }
            else{
                return Optional.empty();
            }
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();


    }

    public Optional<user_profile> getProfileByFirebaseId(String firebaseId) {
        // Using the JPQL method
        return authDao.findProfileByFirebaseId(firebaseId).stream().findFirst();
    }

    public Optional<user_profile> getProfileById(String userid) {
        // Using the JPQL method
        return authDao.findProfileById(userid).stream().findFirst();
    }


}
