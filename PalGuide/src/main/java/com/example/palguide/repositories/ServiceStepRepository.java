package com.example.palguide.repositories;

import com.example.palguide.common.Models.ServiceStep;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceStepRepository extends CrudRepository<ServiceStep, Long> {
}
