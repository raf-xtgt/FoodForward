package com.foodforward.WebServiceApplication.model.container;

import com.foodforward.WebServiceApplication.model.databaseSchema.fileUpload.file_storage_ref;

public class FileStorageRef {
    private final file_storage_ref  file_storage_ref;

    public FileStorageRef(file_storage_ref file_storage_ref) {
        this.file_storage_ref = file_storage_ref;
    }
    public FileStorageRef() {
        this.file_storage_ref = new file_storage_ref();
    }

    public file_storage_ref getFile_storage_ref() {
        return file_storage_ref;
    }
}
