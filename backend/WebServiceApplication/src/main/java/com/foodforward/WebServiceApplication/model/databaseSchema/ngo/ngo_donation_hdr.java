package com.foodforward.WebServiceApplication.model.databaseSchema.ngo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class ngo_donation_hdr {
    @Id
    private String guid;
    private String doc_no;
    private String ngo_guid;
    private String ngo_name;
    private String ngo_code;
    private String donor_id;
    @Column(columnDefinition = "TEXT")
    private String description;
    private String created_date;
    private String updated_date;
    private static String schemaAlias = "ngo_donation_hdr";

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getDocNo() {
        return doc_no;
    }

    public void setDocNo(String docNo) {
        this.doc_no = docNo;
    }

    public String getNgo_guid() {
        return ngo_guid;
    }

    public void setNgo_guid(String ngo_guid) {
        this.ngo_guid = ngo_guid;
    }

    public String getNgo_name() {
        return ngo_name;
    }

    public void setNgo_name(String ngo_name) {
        this.ngo_name = ngo_name;
    }

    public String getNgo_code() {
        return ngo_code;
    }

    public void setNgo_code(String ngo_code) {
        this.ngo_code = ngo_code;
    }

    public String getDonor_id() {
        return donor_id;
    }

    public void setDonor_id(String donor_id) {
        this.donor_id = donor_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(String updated_date) {
        this.updated_date = updated_date;
    }

    public static String getSchemaAlias() {
        return schemaAlias;
    }

    public static void setSchemaAlias(String schemaAlias) {
        ngo_donation_hdr.schemaAlias = schemaAlias;
    }
}
