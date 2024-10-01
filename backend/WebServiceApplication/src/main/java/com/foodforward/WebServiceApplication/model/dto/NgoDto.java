package com.foodforward.WebServiceApplication.model.dto;

public class NgoDto {
    private final String name;
    private final String code;
    private final String desc;

    public NgoDto(String name, String code, String desc) {
        this.name = name;
        this.code = code;
        this.desc = desc;
    }

    public NgoDto() {
        this.name = "";
        this.code = "";
        this.desc = "";
    }

    public String getName() {
        return name;
    }

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
