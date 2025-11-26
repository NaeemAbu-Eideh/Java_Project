package com.example.palguide.services;

import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.repositories.ServiceStepRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceStepService {
    @Autowired
    ServiceStepRepository serviceStepRepository;

    public List<ServiceStep> getAllServiceSteps() {
        return serviceStepRepository.findAll();
    }
}
