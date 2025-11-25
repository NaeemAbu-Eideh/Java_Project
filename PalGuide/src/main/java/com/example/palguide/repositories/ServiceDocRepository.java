package com.example.palguide.repositories;


import com.example.palguide.Models.ServiceDoc;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceDocRepository extends CrudRepository<ServiceDoc, Long> {
}
