package com.example.palguide.common.Models;

import com.example.palguide.common.enums.Role;
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

    @Setter
    @Size(max = 255)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Email(message = UserMessage.EMAIL)
    @Column(name = "email", nullable = false)
    private String email;

    @Setter
    @Size(max = 50, message = UserMessage.FNAME)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "firstname", nullable = false, length = 50)
    private String firstname;

    @Setter
    @Size(max = 50, message = UserMessage.LNAME)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "lastname", nullable = false, length = 50)
    private String lastname;

    @Setter
    @Pattern(regexp = "^.{10}$|^.{14}$", message = UserMessage.PHONE)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "phone", nullable = false)
    private String phone;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.PASSWORD)
    private String password;

    @Setter
    @Transient
    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.CONFIRMPASSWORD)
    private String confirmPassword;

    @Setter
    @NotNull(message = UserMessage.NOTNULL)
    @Column(name = "dob", nullable = false)
    private LocalDate dob;

    @Setter
    @Size(max = 45)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "national_id", nullable = false, length = 45)
    private String nationalId;

    @Setter
    @Size(max = 45)
    @Column(name = "profile_image", length = 45)
    private String profileImage;

    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @ColumnDefault("'USER'")
    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Setter
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Address> addresses = new LinkedHashSet<>();

    @Setter
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Transaction> transactions = new LinkedHashSet<>();

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

}