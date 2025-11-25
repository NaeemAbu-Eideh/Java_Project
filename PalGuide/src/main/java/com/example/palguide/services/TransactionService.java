package com.example.palguide.services;

import com.example.palguide.repositories.ServiceDocRepository;
import com.example.palguide.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransactionService {
    @Autowired
    TransactionRepository transactionRepository;
}
