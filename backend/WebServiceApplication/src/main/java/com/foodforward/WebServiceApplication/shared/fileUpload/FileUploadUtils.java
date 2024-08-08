package com.foodforward.WebServiceApplication.shared.fileUpload;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
public class FileUploadService {

    public Storage getFirebaseStorageInstance(){
        return StorageOptions.getDefaultInstance().getService();
    }

}
