package com.example.palguide.common.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
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

    @Setter
    @NotBlank(message = ServiceDocMessage.NOTBLANK)
    @Column(name = "text", nullable = false)
    private String text;

    @Setter
    @Size(max = 255, message = ServiceDocMessage.FILE)
    @Column(name = "file")
    private String file;

    @Setter
    @Column(name = "image")
    private String image;

    @Column(name = "created_at")
    private Instant createdAt;

    @Size(max = 45)
    @Column(name = "`updated_at(6)`", length = 45)
    private String updatedAt;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "servicessteps_id", nullable = false)
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