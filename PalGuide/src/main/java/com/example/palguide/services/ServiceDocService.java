package com.example.palguide.services;

import com.example.palguide.common.Models.ServiceDoc;
import com.example.palguide.repositories.ServiceDocRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceDocService {
    @Autowired
    ServiceDocRepository serviceDocRepository;

    public List<ServiceDoc> getAllServiceDocs() {
        return serviceDocRepository.findAll();
    }
}
