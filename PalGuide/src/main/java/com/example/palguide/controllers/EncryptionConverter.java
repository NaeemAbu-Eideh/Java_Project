package com.example.palguide.controllers; // 👈 غيّرها حسب الباكيج عندك

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.jasypt.salt.StringFixedSaltGenerator;

@Converter
public class EncryptionConverter implements AttributeConverter<String, String> {

    private static final StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();

    static {
        SimpleStringPBEConfig config = new SimpleStringPBEConfig();

        config.setPassword("CHANGE_THIS_SECRET_PASSWORD");

        config.setAlgorithm("PBEWithMD5AndDES");

        config.setKeyObtentionIterations("1000");

        config.setStringOutputType("base64");

        config.setSaltGenerator(new StringFixedSaltGenerator("MY_FIXED_SALT_VALUE_123456789"));

        encryptor.setConfig(config);
    }

    @Override
    public String convertToDatabaseColumn(String attribute) {
        if (attribute == null || attribute.isEmpty()) {
            return attribute;
        }
        return encryptor.encrypt(attribute);
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isEmpty()) {
            return dbData;
        }
        return encryptor.decrypt(dbData);
    }
}
