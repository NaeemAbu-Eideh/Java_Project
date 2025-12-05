package com.example.palguide.services.impl;

import com.example.palguide.services.GeminiService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class GeminiServiceImpl implements GeminiService {

    private static final OkHttpClient client = new OkHttpClient();

    @Value("${gemini.api.key}")
    private String apiKey;

    @Override
    public String getAnalysisFromGemini(MultipartFile file) throws IOException {

        String base64File = java.util.Base64.getEncoder()
                .encodeToString(file.getBytes());

        String prompt = """
                You are an expert government assistant. Your job is to analyze the uploaded document and extract structured information.

                Return a valid JSON object ONLY with this exact structure:

                {
                  "documentType": "",
                  "estimatedTime": "",
                  "requirements": [],
                  "steps": []
                }

                Rules:
                - If the document explicitly mentions requirements or steps, extract them exactly.
                - If the document does NOT contain requirements or steps, INFER them logically based on the document type.
                - Always fill all fields with meaningful, realistic values.
                - Do NOT leave requirements or steps empty unless absolutely impossible.
                - Do NOT wrap the JSON in markdown or backticks.

                """;

        String jsonBody = """
                {
                  "contents": [{
                    "parts": [
                      { "text": "%s" },
                      {
                        "inline_data": {
                          "mime_type": "%s",
                          "data": "%s"
                        }
                      }
                    ]
                  }]
                }
                """.formatted(
                prompt.replace("\"", "\\\""),
                file.getContentType(),
                base64File);

        RequestBody body = RequestBody.create(
                jsonBody,
                MediaType.parse("application/json"));

        Request request = new Request.Builder()
                .url("https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=" + apiKey)
                .post(body)
                .build();

        String responseText;
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                System.out.println("Error body: " + response.body().string());
                throw new IOException("Unexpected code " + response);
            }
            responseText = response.body().string();
        }

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(responseText);

        String aiText = root
                .get("candidates").get(0)
                .get("content").get("parts").get(0)
                .get("text").asText();

        return aiText
                .replace("```json", "")
                .replace("```", "")
                .trim();
    }
}
