package com.example.palguide.common.Models;

import com.example.palguide.common.enums.Role;
import com.example.palguide.controllers.EncryptionConverter;
import com.example.palguide.controllers.LocalDateEncryptionConverter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Email(message = UserMessage.EMAIL)
    @Column(name = "email", nullable = false, unique = true, length = 255)
    private String email;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "firstname", nullable = false, length = 255)
    private String firstname;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "lastname", nullable = false, length = 255)
    private String lastname;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @Pattern(regexp = "^.{10}$|^.{14}$", message = UserMessage.PHONE)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "phone", nullable = false, length = 255)
    private String phone;


    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.PASSWORD)
    private String password;

    @Setter
    @Transient
    private String confirmPassword;



    @Convert(converter = LocalDateEncryptionConverter.class)
    @Setter
    @NotNull(message = UserMessage.NOTNULL)
    @Column(name = "dob", nullable = false)
    private LocalDate dob;

    @Convert(converter = EncryptionConverter.class)
    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "national_id", nullable = false, length = 255)
    private String nationalId;

    @Setter
    @Lob
    @Column(name = "profile_image", columnDefinition = "LONGBLOB")
    private byte[] profileImage;

    @Setter
    @ColumnDefault("'USER'")
    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role = Role.USER;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Address> addresses = new LinkedHashSet<>();

    @Setter
    @JsonIgnore
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Transaction> transactions = new LinkedHashSet<>();

    @Setter
    private String resetToken;


    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

}