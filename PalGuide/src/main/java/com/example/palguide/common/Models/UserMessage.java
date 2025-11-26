package com.example.palguide.common.Models;

public interface UserMessage {
    public static final String NOTBLANK = "this field does not be blank";
    public static final String NOTNULL = "this field does not be null";
    public static final String EMAIL = "the email must be valid";
    public static final String FNAME = "the first name must be less than 50 characters";
    public static final String LNAME = "the last name must be less than 50 characters";
    public static final String PASSWORD = "the password must be at least 8";
    public static final String CONFIRMPASSWORD = "the confirm password must be at least 8";
    public static final String PHONE = "the phone number must be 10 or 14 digits";
}
