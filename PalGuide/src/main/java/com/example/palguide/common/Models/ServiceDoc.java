package com.example.palguide.common.Models;


import com.example.palguide.controllers.EncryptionConverter;
import jakarta.persistence.*;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Entity
@Table(name = "service_doc")
public class ServiceDoc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @Size(max = 255, message = ServiceDocMessage.FILE)
    @Column(name = "file", length = 255)
    private String file;

    @Column(name = "created_at")
    private Instant createdAt;

    @Convert(converter = EncryptionConverter.class)
    @Size(max = 45)
    @Column(name = "`updated_at(6)`", length = 255)
    private String updatedAt;

    @Setter
    @OneToOne(mappedBy = "serviceDoc", cascade = CascadeType.ALL)
    private ServiceStep serviceStep;


    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now().toString();
    }

}