package com.example.palguide.services;

import com.example.palguide.common.DTO.TransactionStatusCountsDTO;
import com.example.palguide.common.Models.Transaction;
import com.example.palguide.common.enums.Status;
import com.example.palguide.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionService {
    @Autowired
    TransactionRepository transactionRepository;

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
    }

    public List<Transaction> getTransactionsByStatus(Status status) {
        return transactionRepository.findByStatus(status);
    }

    public Transaction getTransactionById(Long id) {
        return transactionRepository.findById(id).orElse(null);
    }

    public Transaction saveTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    public TransactionStatusCountsDTO getStatusCounts() {

        Long all = transactionRepository.count();
        Long pending = transactionRepository.countByStatus(Status.PENDING);
        Long inProgress = transactionRepository.countByStatus(Status.UNDER_REVIEW);
        Long completed = transactionRepository.countByStatus(Status.COMPLETED);
        Long rejected = transactionRepository.countByStatus(Status.REJECTED);

        return new TransactionStatusCountsDTO(all, pending, inProgress, completed, rejected);
    }

}
