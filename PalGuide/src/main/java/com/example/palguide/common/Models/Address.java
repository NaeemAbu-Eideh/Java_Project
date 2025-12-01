package com.example.palguide.common.Models;


import com.example.palguide.controllers.EncryptionConverter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Entity
@Table(name = "address")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @Size(max = 255, message = AddressMessage.STATE)
    @NotBlank(message = AddressMessage.NOTBLANK)
    @Column(name = "state", nullable = false)
    private String state;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @Size(max = 255)
    @NotBlank(message = AddressMessage.CITY)
    @Column(name = "city", nullable = false)
    private String city;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @Size(max = 255)
    @NotBlank(message = AddressMessage.STREET)
    @Column(name = "street", nullable = false)
    private String street;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JsonIgnore
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

}