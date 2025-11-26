package com.example.palguide.repositories;

import com.example.palguide.common.Models.ServiceStep;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceStepRepository extends CrudRepository<ServiceStep, Long> {
    List<ServiceStep> findAll();
}
