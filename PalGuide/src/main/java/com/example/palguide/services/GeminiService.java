package com.example.palguide.services;

import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;

public interface GeminiService {
    String getAnalysisFromGemini(MultipartFile file) throws IOException;
}
