package com.example.palguide.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 155, message = TransactionMessage.TITLE)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "title", nullable = false, length = 155)
    private String title;

    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "description", nullable = false)
    private String description;

    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "type", nullable = false)
    private String type;

    @NotBlank(message = UserMessage.NOTBLANK)
    @ColumnDefault("'PENDING'")
    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "transaction", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ServiceStep> servicessteps = new LinkedHashSet<>();

}