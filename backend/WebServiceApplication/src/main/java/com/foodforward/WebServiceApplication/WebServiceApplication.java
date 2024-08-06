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

import java.io.*;
import java.util.Objects;

@SpringBootApplication
public class WebServiceApplication {

	private static final Log log = LogFactory.getLog(WebServiceApplication.class);

	public static void main(String[] args) throws IOException {
		File file = new File(Objects.requireNonNull(WebServiceApplication.class.getClassLoader().getResource("serviceKeyAccount.json")).getFile());
		FileInputStream serviceAccount =
				new FileInputStream(file.getAbsolutePath());

		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.fromStream(serviceAccount))
				.build();
		FirebaseApp.initializeApp(options);
		SpringApplication.run(WebServiceApplication.class, args);

	}


}
