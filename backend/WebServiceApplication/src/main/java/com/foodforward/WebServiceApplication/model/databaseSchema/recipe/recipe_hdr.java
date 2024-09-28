package com.foodforward.WebServiceApplication.model.databaseSchema.recipe;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.time.Instant;

@Entity
public class recipe_hdr {
    @Id
    private String guid;
    @Column(columnDefinition = "TEXT")
    private String recipe_text;
    private String created_by_user_guid;
    private String updated_by_user_guid;
    private String created_date;
    private String updated_date;
    private static String schemaAlias = "recipe_hdr";

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getRecipe_text() {
        return recipe_text;
    }

    public void setRecipe_text(String recipe_text) {
        this.recipe_text = recipe_text;
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
        recipe_hdr.schemaAlias = schemaAlias;
    }
}
