package com.example.palguide.repositories;


import com.example.palguide.common.Models.ServiceDoc;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceDocRepository extends CrudRepository<ServiceDoc, Long> {
    List<ServiceDoc> findAll();
}
