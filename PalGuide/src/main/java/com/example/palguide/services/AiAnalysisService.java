package com.example.palguide.services;

import com.example.palguide.common.Models.ServiceStep;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface AiAnalysisService {
    ServiceStep analyzeDocument(MultipartFile file) throws IOException;
}
