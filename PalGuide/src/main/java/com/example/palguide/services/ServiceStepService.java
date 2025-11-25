package com.example.palguide.services;

import com.example.palguide.repositories.ServiceStepRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceStepService {
    @Autowired
    ServiceStepRepository serviceStepRepository;
}
