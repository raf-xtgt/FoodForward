package com.foodforward.WebServiceApplication.shared.fileUpload;
import com.foodforward.WebServiceApplication.WebServiceApplication;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.File;
import java.io.FileInputStream;
import java.util.Objects;

public class FileUploadUtils {
    private static final Log log = LogFactory.getLog(FileUploadUtils.class);

    public Storage getFirebaseStorageInstance(){
        Storage storage = null;
        try{
            File file = new File(Objects.requireNonNull(WebServiceApplication.class.getClassLoader().getResource("serviceKeyAccount.json")).getFile());
            FileInputStream serviceAccount =
                    new FileInputStream(file.getAbsolutePath());
            storage = StorageOptions.newBuilder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                            .build()
                            .getService();
        }
        catch(Exception e){
            log.error(e.getMessage());
        }
        return storage;
    }

}
