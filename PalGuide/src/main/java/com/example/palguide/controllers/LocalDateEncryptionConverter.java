package com.example.palguide.controllers; // غيّر حسب مشروعك

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.jasypt.salt.StringFixedSaltGenerator;

import java.time.LocalDate;

@Converter(autoApply = false)
public class LocalDateEncryptionConverter implements AttributeConverter<LocalDate, String> {

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
    public String convertToDatabaseColumn(LocalDate localDate) {
        if (localDate == null)
            return null;

        String dateString = localDate.toString();   // مثال: "2025-11-29"

        return encryptor.encrypt(dateString);
    }

    @Override
    public LocalDate convertToEntityAttribute(String dbData) {
        if (dbData == null)
            return null;

        String decryptedString = encryptor.decrypt(dbData);
        return LocalDate.parse(decryptedString);
    }
}
