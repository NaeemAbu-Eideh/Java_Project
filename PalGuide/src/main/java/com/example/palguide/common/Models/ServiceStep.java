package com.example.palguide.common.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Getter
@Entity
@Table(name = "service_steps")
public class ServiceStep {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Setter
    @Column(name = "document_type", nullable = false)
    private String documentType;


    @Setter
    @ElementCollection
    @CollectionTable(name = "service_requirements", joinColumns = @JoinColumn(name = "service_step_id"))
    @Column(name = "requirement")
    private List<String> requirements;


    @Setter
    @ElementCollection
    @CollectionTable(name = "service_process_steps", joinColumns = @JoinColumn(name = "service_step_id"))
    @Column(name = "step")
    private List<String> steps;


    @Setter
    @Column(name = "estimated_time")
    private String estimatedTime;


    @Setter
    @NotNull
    @Column(name = "completed", nullable = false)
    private Byte completed = 0;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @OneToOne
    @JoinColumn(name = "service_doc_id", nullable = false, unique = true)
    private ServiceDoc serviceDoc;

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }
}
