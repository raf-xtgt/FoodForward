package com.foodforward.WebServiceApplication.model.databaseSchema.ocr;
import java.time.Instant;

public class ocr_processing_queue {
    private String guid;
    private String file_ref_guid;
    private String file_name;
    private String file_url;
    private String descr;
    private String created_by_id;
    private String updated_by_id;
    private Instant created_date;
    private Instant updated_date;
    private static String schemaAlias = "ocr_processing_queue";

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getFile_ref_guid() {
        return file_ref_guid;
    }

    public void setFile_ref_guid(String file_ref_guid) {
        this.file_ref_guid = file_ref_guid;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getCreated_by_id() {
        return created_by_id;
    }

    public void setCreated_by_id(String created_by_id) {
        this.created_by_id = created_by_id;
    }

    public String getUpdated_by_id() {
        return updated_by_id;
    }

    public void setUpdated_by_id(String updated_by_id) {
        this.updated_by_id = updated_by_id;
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
        ocr_processing_queue.schemaAlias = schemaAlias;
    }
}
