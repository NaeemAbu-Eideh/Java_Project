package com.example.palguide.common.enums;

import lombok.Getter;

@Getter
public enum Type {
    PASSPORT_RENEWAL("Passport Renewal", 50),
    ID_RENEWAL("National ID Renewal", 30),
    BIRTH_CERTIFICATE("Birth Certificate Request", 20);

    private final String displayName;
    private final long amount;

    Type(String displayName, long amount) {
        this.displayName = displayName;
        this.amount = amount;
    }

}
