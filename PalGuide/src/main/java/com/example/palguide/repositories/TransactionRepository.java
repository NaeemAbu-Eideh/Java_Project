package com.example.palguide.repositories;

import com.example.palguide.Models.Transaction;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransactionRepository  extends CrudRepository<Transaction, Long> {
}
