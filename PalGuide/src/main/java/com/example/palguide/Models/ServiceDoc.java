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
@Table(name = "servicedoc")
public class ServiceDoc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = ServiceDocMessage.NOTBLANK)
    @Column(name = "text", nullable = false)
    private String text;


    @Size(max = 255, message = ServiceDocMessage.FILE)
    @Column(name = "file")
    private String file;

    @Column(name = "image")
    private String image;

    @Column(name = "created_at")
    private Instant createdAt;

    @Size(max = 45)
    @Column(name = "`updated_at(6)`", length = 45)
    private String updatedAt6;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "servicessteps_id", nullable = false)
    private ServiceStep servicessteps;

}