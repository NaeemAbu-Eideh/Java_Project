package com.example.palguide.common.Models;

import com.example.palguide.common.enums.Payment;
import com.example.palguide.common.enums.Status;
import com.example.palguide.common.enums.Type;
import com.example.palguide.controllers.EncryptionConverter;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import java.time.Instant;

@Getter
@Entity
@Table(name = "transaction")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = TransactionMessage.TITLE)
    @Column(name = "title", nullable = false, length = 255)
    private String title;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "description", nullable = false, length = 255)
    private String description;


    @Setter
    @NotNull(message = "Type cannot be null")
    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private Type type;

    @Setter
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status = Status.PENDING;

    @Setter
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status", nullable = false)
    private Payment paymentStatus = Payment.NOT_PAID;

    @Setter
    @NotNull(message = "Amount is required")
    @Column(name = "amount", nullable = false)
    private Long amount;


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
