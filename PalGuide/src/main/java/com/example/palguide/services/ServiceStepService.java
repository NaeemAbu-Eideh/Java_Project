package com.example.palguide.services;

import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.common.Models.Transaction;
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

    public ServiceStep saveAnalysis(String documentType, List<String> requirements, List<String> processSteps, String estimatedTime, Transaction transaction) {
        ServiceStep step = new ServiceStep();
        step.setDocumentType(documentType);
        step.setRequirements(requirements);
        step.setSteps(processSteps);
        step.setEstimatedTime(estimatedTime);
        step.setCompleted((byte) 1);
        step.setTransaction(transaction);

        return serviceStepRepository.save(step);
    }
}
