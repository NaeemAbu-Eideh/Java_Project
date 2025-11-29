package com.example.palguide.controllers;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import org.jasypt.util.text.AES256TextEncryptor;

@Converter
public class EncryptionConverter implements AttributeConverter<String, String> {

    private static final AES256TextEncryptor encryptor = new AES256TextEncryptor();

    static {
        String password = "VERY_STRONG_SECRET_KEY_123";
        encryptor.setPassword(password);
    }

    @Override
    public String convertToDatabaseColumn(String attribute) {
        if (attribute == null) return null;
        return encryptor.encrypt(attribute);
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return encryptor.decrypt(dbData);
    }
}

