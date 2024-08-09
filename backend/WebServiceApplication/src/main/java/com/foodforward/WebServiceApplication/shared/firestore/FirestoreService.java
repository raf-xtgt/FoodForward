package com.foodforward.WebServiceApplication.shared.firestore;

import com.foodforward.WebServiceApplication.databaseConnection.DatabaseConnectionService;
import com.foodforward.WebServiceApplication.service.fileReference.FileUploadService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.concurrent.ExecutionException;

public class FirestoreService {
    private static final Log log = LogFactory.getLog(FirestoreService.class);

    public <T> T getDocument(String collectionName, String documentId, Class<T> clazz) throws ExecutionException, InterruptedException {
        final Firestore db = new DatabaseConnectionService().getDbConnection();
        DocumentReference docRef = db.collection(collectionName).document(documentId);
        ApiFuture<DocumentSnapshot> future = docRef.get();
        DocumentSnapshot document = future.get();

        if (document.exists()) {
            return document.toObject(clazz);
        } else {
            throw new RuntimeException("Document not found");
        }
    }
}
