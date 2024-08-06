package com.foodforward.WebServiceApplication;

import com.google.firebase.cloud.FirestoreClient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;

import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@SpringBootApplication
public class WebServiceApplication {

	private static final Log log = LogFactory.getLog(WebServiceApplication.class);

	public static void main(String[] args) {
		final Firestore dbConn = getFirestoreDbConn();
		SpringApplication.run(WebServiceApplication.class, args);

	}

	private static Firestore getFirestoreDbConn(){
		Firestore db = null;
		try{
			GoogleCredentials credentials = GoogleCredentials.getApplicationDefault();
			FirebaseOptions options = new FirebaseOptions.Builder()
					.setCredentials(credentials)
					.setProjectId("foodforward-3c212")
					.build();
			FirebaseApp.initializeApp(options);

			db = FirestoreClient.getFirestore();
		}
		catch(Exception e){
			log.error("Failed to connect to database" + e.getMessage());
			e.printStackTrace();
		}
		return db;
	}

}
