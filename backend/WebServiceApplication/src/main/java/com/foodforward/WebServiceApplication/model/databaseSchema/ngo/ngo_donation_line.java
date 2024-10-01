package com.foodforward.WebServiceApplication.model.databaseSchema.ngo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class ngo_donation_line {
    @Id
    private String guid;
    private String hdr_guid;
    private String food_stock_guid;
    private String food_stock_name;
    private String food_stock_exp_date;
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

    public String getHdr_guid() {
        return hdr_guid;
    }

    public void setHdr_guid(String hdr_guid) {
        this.hdr_guid = hdr_guid;
    }

    public String getFood_stock_guid() {
        return food_stock_guid;
    }

    public void setFood_stock_guid(String food_stock_guid) {
        this.food_stock_guid = food_stock_guid;
    }

    public String getFood_stock_name() {
        return food_stock_name;
    }

    public void setFood_stock_name(String food_stock_name) {
        this.food_stock_name = food_stock_name;
    }

    public String getFood_stock_exp_date() {
        return food_stock_exp_date;
    }

    public void setFood_stock_exp_date(String food_stock_exp_date) {
        this.food_stock_exp_date = food_stock_exp_date;
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
        ngo_donation_line.schemaAlias = schemaAlias;
    }
}
