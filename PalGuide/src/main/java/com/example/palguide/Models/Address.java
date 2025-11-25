package com.example.palguide.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "address")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 255, message = AddressMessage.STATE)
    @NotBlank(message = AddressMessage.NOTBLANK)
    @Column(name = "state", nullable = false)
    private String state;

    @Size(max = 255)
    @NotBlank(message = AddressMessage.CITY)
    @Column(name = "city", nullable = false)
    private String city;

    @Size(max = 255)
    @NotBlank(message = AddressMessage.STREET)
    @Column(name = "street", nullable = false)
    private String street;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

}