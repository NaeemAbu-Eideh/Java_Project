package com.example.palguide.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 255)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Email(message = UserMessage.EMAIL)
    @Column(name = "email", nullable = false)
    private String email;

    @Size(max = 50, message = UserMessage.FNAME)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "firstname", nullable = false, length = 50)
    private String firstname;

    @Size(max = 50, message = UserMessage.LNAME)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "lastname", nullable = false, length = 50)
    private String lastname;

    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.PASSWORD)
    private String password;

    @Transient
    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.CONFIRMPASSWORD)
    private String confirmPassword;

    @NotNull(message = UserMessage.NOTNULL)
    @Column(name = "dob", nullable = false)
    private LocalDate dob;

    @Size(max = 45)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Column(name = "national_id", nullable = false, length = 45)
    private String nationalId;

    @Size(max = 45)
    @Column(name = "profile_image", length = 45)
    private String profileImage;

    @NotBlank(message = UserMessage.NOTBLANK)
    @ColumnDefault("'USER'")
    @Column(name = "role", nullable = false)
    private String role;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @OneToMany(mappedBy = "user")
    private Set<Address> addresses = new LinkedHashSet<>();

    @OneToMany(mappedBy = "user")
    private Set<Transaction> transactions = new LinkedHashSet<>();

}