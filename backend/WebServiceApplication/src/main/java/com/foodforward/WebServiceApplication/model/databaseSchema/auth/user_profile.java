package com.foodforward.WebServiceApplication.model.databaseSchema.auth;

import com.foodforward.WebServiceApplication.model.container.auth.AuthLoginType;


public class user_profile {
    private String guid;
    private String username;
    private String access_token;
    private AuthLoginType login_type;
    private String created_date;
    private String updated_date;
    private static String schemaAlias = "user_profile";

    public user_profile(String guid, String username, String access_token, AuthLoginType login_type,
                        String created_date, String updated_date) {
        this.guid = guid;
        this.username = username;
        this.access_token = access_token;
        this.login_type = login_type;
        this.created_date = created_date;
        this.updated_date = updated_date;
    }

    public user_profile() {
        this.guid = null;
        this.username = null;
        this.access_token = null;
        this.login_type = null;
        this.created_date = null;
        this.updated_date = null;
    }

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public AuthLoginType getLogin_type() {
        return login_type;
    }

    public void setLogin_type(AuthLoginType login_type) {
        this.login_type = login_type;
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
        user_profile.schemaAlias = schemaAlias;
    }
}
