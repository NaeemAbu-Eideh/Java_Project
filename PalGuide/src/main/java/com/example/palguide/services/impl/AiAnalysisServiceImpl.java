package com.example.palguide.services.impl;

import com.example.palguide.common.Models.ServiceDoc;
import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.services.AiAnalysisService;
import com.example.palguide.services.GeminiService;
import com.example.palguide.services.ServiceDocService;
import com.example.palguide.services.ServiceStepService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class AiAnalysisServiceImpl implements AiAnalysisService {

    private final ServiceDocService serviceDocService;
    private final ServiceStepService serviceStepService;
    private final GeminiService geminiService;

    @Value("${file.upload-dir:uploads/service_docs}")
    private String uploadDir;

    @Autowired
    public AiAnalysisServiceImpl(ServiceDocService serviceDocService, ServiceStepService serviceStepService,
            GeminiService geminiService) {
        this.serviceDocService = serviceDocService;
        this.serviceStepService = serviceStepService;
        this.geminiService = geminiService;
    }

    // For testing
    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    @Override
    public ServiceStep analyzeDocument(MultipartFile file) throws IOException {
        // 1. Get Analysis from Gemini
        String analysisJson = geminiService.getAnalysisFromGemini(file);

        // 2. Parse JSON
        ObjectMapper mapper = new ObjectMapper();
        JsonNode node = mapper.readTree(analysisJson);

        // 3. Save File
        String originalName = file.getOriginalFilename();
        String extension = "";
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf("."));
        }
        String fileName = "doc_" + System.currentTimeMillis() + extension;

        Path uploadPath = Paths.get(uploadDir);
        Files.createDirectories(uploadPath);
        Path filePath = uploadPath.resolve(fileName);
        Files.write(filePath, file.getBytes());

        ServiceDoc newDoc = new ServiceDoc();
        newDoc.setFile(fileName);
        serviceDocService.saveDoc(newDoc);

        // 4. Create and Save Analysis
        ServiceStep step = new ServiceStep();
        if (node.has("documentType"))
            step.setDocumentType(node.get("documentType").asText());
        if (node.has("estimatedTime"))
            step.setEstimatedTime(node.get("estimatedTime").asText());
        if (node.has("requirements"))
            step.setRequirements(mapper.convertValue(node.get("requirements"), List.class));
        if (node.has("steps"))
            step.setSteps(mapper.convertValue(node.get("steps"), List.class));
        step.setServiceDoc(newDoc);

        serviceStepService.saveAnalysis(step);

        return step;
    }
}
