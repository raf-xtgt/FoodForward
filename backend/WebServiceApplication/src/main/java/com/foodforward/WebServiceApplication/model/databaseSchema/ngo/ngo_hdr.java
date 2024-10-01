package com.foodforward.WebServiceApplication.model.databaseSchema.ngo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class ngo_hdr {
    @Id
    private String guid;
    private String name;
    private String code;
    @Column(columnDefinition = "TEXT")
    private String description;
    private String created_date;
    private String updated_date;
    private static String schemaAlias = "ngo_hdr";

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public static void setSchemaAlias(String schemaAlias) {
        ngo_hdr.schemaAlias = schemaAlias;
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

}
