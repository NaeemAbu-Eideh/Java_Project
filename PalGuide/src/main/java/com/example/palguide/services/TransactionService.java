package com.example.palguide.services;

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

    public List<Transaction> getTransactionsByStatus(Status status,Long id) {
        return transactionRepository.findByStatusAndUser_Id(status,id);
    }
}
