package com.example.palguide.common.DTO;

import lombok.Getter;

@Getter
public class UserVerifiedCountsDTO {
    private Long all;
    private Long pending;
    private Long approved;
    private Long rejected;

    public UserVerifiedCountsDTO(Long all, Long pending, Long approved, Long rejected) {
        this.all = all;
        this.pending = pending;
        this.approved = approved;
        this.rejected = rejected;
    }

}


