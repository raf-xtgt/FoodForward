package com.foodforward.WebServiceApplication.model.databaseSchema.receipt;

import java.math.BigDecimal;
import java.time.ZonedDateTime;
import java.util.UUID;

public class receipt_document_hdr {
    private UUID guid;
    private String receipt_no;
    private ZonedDateTime receipt_date_txn;
    private String receipt_reference;
    private String descr;
    private BigDecimal total_amt;
    private String file_url;
    private String file_storage_ref_guid;
    private String created_by_user_guid;
    private String updated_by_user_guid;
    private ZonedDateTime created_date;
    private ZonedDateTime updated_date;
    private static String schemaAlias = "receipt_document_hdr";

    public UUID getGuid() {
        return guid;
    }

    public void setGuid(UUID guid) {
        this.guid = guid;
    }

    public String getReceipt_no() {
        return receipt_no;
    }

    public void setReceipt_no(String receipt_no) {
        this.receipt_no = receipt_no;
    }

    public ZonedDateTime getReceipt_date_txn() {
        return receipt_date_txn;
    }

    public void setReceipt_date_txn(ZonedDateTime receipt_date_txn) {
        this.receipt_date_txn = receipt_date_txn;
    }

    public String getReceipt_reference() {
        return receipt_reference;
    }

    public void setReceipt_reference(String receipt_reference) {
        this.receipt_reference = receipt_reference;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public BigDecimal getTotal_amt() {
        return total_amt;
    }

    public void setTotal_amt(BigDecimal total_amt) {
        this.total_amt = total_amt;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public String getFile_storage_ref_guid() {
        return file_storage_ref_guid;
    }

    public void setFile_storage_ref_guid(String file_storage_ref_guid) {
        this.file_storage_ref_guid = file_storage_ref_guid;
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

    public ZonedDateTime getCreated_date() {
        return created_date;
    }

    public void setCreated_date(ZonedDateTime created_date) {
        this.created_date = created_date;
    }

    public ZonedDateTime getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(ZonedDateTime updated_date) {
        this.updated_date = updated_date;
    }

    public static String getSchemaAlias() {
        return schemaAlias;
    }

    public static void setSchemaAlias(String schemaAlias) {
        receipt_document_hdr.schemaAlias = schemaAlias;
    }
}
