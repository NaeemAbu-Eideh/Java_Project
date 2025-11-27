package com.example.palguide.common.Models;

import com.example.palguide.common.enums.Status;
import com.example.palguide.common.enums.Type;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Entity
@Table(name = "transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Setter
    @Size(max = 155, message = TransactionMessage.TITLE)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "title", nullable = false, length = 155)
    private String title;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "description", nullable = false)
    private String description;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private Type type;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @ColumnDefault("'PENDING'")
    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private Status status = Status.PENDING;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
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