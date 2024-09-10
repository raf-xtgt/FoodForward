package com.foodforward.WebServiceApplication.model.databaseSchema.fileReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.time.Instant;

@Entity
public class file_storage_ref {
    @Id
    private String guid;
    private String file_name;
    @Column(columnDefinition = "TEXT")
    private String file_string;
    private String descr;
    private String created_by_user_guid;
    private String updated_by_user_guid;
    private Instant created_date;
    private Instant updated_date;
    private static String schemaAlias = "file_storage_ref";

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getFile_string() {
        return file_string;
    }

    public void setFile_string(String file_string) {
        this.file_string = file_string;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getCreated_by_user_guid() {
        return created_by_user_guid;
    }

    public void setCreated_by_user_guid(String created_by_user_guid) {
        this.created_by_user_guid = created_by_user_guid;
    }

    public String getUpdated_by_user_guid() {
        return updated_by_user_guid;
    }

    public void setUpdated_by_user_guid(String updated_by_user_guid) {
        this.updated_by_user_guid = updated_by_user_guid;
    }

    public Instant getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Instant created_date) {
        this.created_date = created_date;
    }

    public Instant getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(Instant updated_date) {
        this.updated_date = updated_date;
    }

    public static String getSchemaAlias() {
        return schemaAlias;
    }

    public static void setSchemaAlias(String schemaAlias) {
        file_storage_ref.schemaAlias = schemaAlias;
    }
}
