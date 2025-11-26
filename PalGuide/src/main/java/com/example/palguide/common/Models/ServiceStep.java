package com.example.palguide.common.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Entity
@Table(name = "servicessteps")
public class ServiceStep {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "text", nullable = false)
    private String text;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "steps", nullable = false)
    private String steps;

    @Setter
    @NotNull(message = UserMessage.NOTNULL)
    @ColumnDefault("0")
    @Column(name = "completed", nullable = false)
    private Byte completed;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "transaction_id", nullable = false)
    private Transaction transaction;

    @Setter
    @OneToMany(mappedBy = "servicessteps", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ServiceDoc> servicedocs = new LinkedHashSet<>();

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

}