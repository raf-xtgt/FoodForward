package com.foodforward.WebServiceApplication.shared.apiResponse.model;

// This is a wrapper class which wraps api data inside a json
public class ApiResponse<T> {
    private int statusCode;
    private T data;

    public ApiResponse(int statusCode, T data){
        this.statusCode = statusCode;
        this.data = data;
    }
    public ApiResponse(){
        this.statusCode = 0;
        this.data = null;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
