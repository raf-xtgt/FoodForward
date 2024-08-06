package com.foodforward.WebServiceApplication.databaseConnection;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class DatabaseConnectionService {
    private static final Log log = LogFactory.getLog(DatabaseConnectionService.class);

    public Firestore getDbConnection(){
       return FirestoreClient.getFirestore();
    }
}
