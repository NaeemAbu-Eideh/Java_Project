package com.example.palguide.repositories;

import com.example.palguide.common.Models.Transaction;
import com.example.palguide.common.enums.Status;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository  extends CrudRepository<Transaction, Long> {
    List<Transaction> findAll();

    List<Transaction> findByStatusAndUser_Id(Status status, Long id);


}
