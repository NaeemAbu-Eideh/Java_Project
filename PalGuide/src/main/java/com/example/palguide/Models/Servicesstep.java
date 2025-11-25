package com.example.palguide.Models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "servicessteps")
public class Servicesstep {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @NotNull
    @Lob
    @Column(name = "text", nullable = false)
    private String text;

    @NotNull
    @Lob
    @Column(name = "steps", nullable = false)
    private String steps;

    @NotNull
    @ColumnDefault("0")
    @Column(name = "completed", nullable = false)
    private Byte completed;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "transaction_id", nullable = false)
    private Transaction transaction;

    @OneToMany(mappedBy = "servicessteps")
    private Set<Servicedoc> servicedocs = new LinkedHashSet<>();

}