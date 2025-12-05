package com.example.palguide.services;

import com.example.palguide.common.Models.ServiceDoc;
import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.services.impl.AiAnalysisServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AiAnalysisServiceTest {

    @Mock
    private ServiceDocService serviceDocService;

    @Mock
    private ServiceStepService serviceStepService;

    @Mock
    private GeminiService geminiService;

    private AiAnalysisServiceImpl aiAnalysisService;

    @Test
    void analyzeDocument_shouldReturnServiceStep_whenAnalysisIsSuccessful() throws IOException {
        // Arrange
        aiAnalysisService = new AiAnalysisServiceImpl(serviceDocService, serviceStepService, geminiService);
        aiAnalysisService.setUploadDir("uploads/service_docs_test"); // Setter injection for test path

        MultipartFile mockFile = mock(MultipartFile.class);
        when(mockFile.getBytes()).thenReturn("fake content".getBytes());
        // when(mockFile.getContentType()).thenReturn("application/pdf"); // Unnecessary
        // stubbing
        when(mockFile.getOriginalFilename()).thenReturn("test.pdf");

        // Mock Gemini Response
        String mockGeminiResponse = "{\"documentType\": \"Passport\", \"estimatedTime\": \"2 days\", \"requirements\": [\"Photo\"], \"steps\": [\"Apply\"]}";
        when(geminiService.getAnalysisFromGemini(mockFile)).thenReturn(mockGeminiResponse);

        // Act
        ServiceStep result = aiAnalysisService.analyzeDocument(mockFile);

        // Assert
        assertNotNull(result);
        verify(serviceDocService).saveDoc(any(ServiceDoc.class));
        verify(serviceStepService).saveAnalysis(any(ServiceStep.class));
    }
}
