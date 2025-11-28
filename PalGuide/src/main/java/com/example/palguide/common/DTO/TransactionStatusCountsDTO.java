package com.example.palguide.common.DTO;

import lombok.Getter;

@Getter
public class TransactionStatusCountsDTO {

    private Long all;
    private Long pending;
    private Long inProgress;
    private Long completed;
    private Long rejected;

    // constructor
    public TransactionStatusCountsDTO(Long all, Long pending, Long inProgress, Long completed, Long rejected) {
        this.all = all;
        this.pending = pending;
        this.inProgress = inProgress;
        this.completed = completed;
        this.rejected = rejected;
    }

}
