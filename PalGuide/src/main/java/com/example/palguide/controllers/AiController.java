package com.example.palguide.controllers;

import com.example.palguide.common.Models.ServiceDoc;
import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.common.Models.User;
import com.example.palguide.services.ServiceDocService;
import com.example.palguide.services.ServiceStepService;
import com.example.palguide.services.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class AiController {

    @Autowired
    ServiceStepService serviceStepService;
    @Autowired
    ServiceDocService serviceDocService;
    @Autowired
    UserService userService;

    @Value("${gemini.api.key}")
    private String apiKey;

    @GetMapping("/analysis")
    public String analysis(Model model, RedirectAttributes attributes, HttpSession session) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            attributes.addFlashAttribute("message", "You are not logged in");
            return "redirect:/login";
        }
        model.addAttribute(userService.getUserById((Long) session.getAttribute("user_id")));
        return "analysis.html";
    }

    @PostMapping("/analysis")
    public String analyze(@RequestParam("file") MultipartFile file, Model model,HttpSession session) {

        try {
            OkHttpClient client = new OkHttpClient();

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
                    base64File
            );

            RequestBody body = RequestBody.create(
                    jsonBody,
                    MediaType.parse("application/json")
            );

            Request request = new Request.Builder()
                    .url("https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=" + apiKey)
                    .post(body)
                    .build();

            Response response = client.newCall(request).execute();
            String responseText = response.body().string();
            System.out.println("RAW GEMINI RESPONSE:\n" + responseText);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(responseText);

            String aiText = root
                    .get("candidates").get(0)
                    .get("content").get("parts").get(0)
                    .get("text").asText();

            System.out.println("heeeere +" + aiText);
            String cleaned = aiText
                    .replace("```json", "")
                    .replace("```", "")
                    .trim();

            System.out.println(cleaned);

            String mime = file.getContentType();
            String originalName = file.getOriginalFilename();
            String extension = originalName.substring(originalName.lastIndexOf("."));
            String fileName = "doc_" + System.currentTimeMillis() + extension;

            Path uploadDir = Paths.get("uploads/service_docs");
            Files.createDirectories(uploadDir);

            Path filePath = uploadDir.resolve(fileName);
            Files.write(filePath, file.getBytes());

            ServiceDoc newDoc = new ServiceDoc();
            newDoc.setFile(fileName);


            serviceDocService.saveDoc(newDoc);

            JsonNode node = mapper.readTree(cleaned);
            ServiceStep step = new ServiceStep();
            step.setDocumentType(node.get("documentType").asText());
            step.setEstimatedTime(node.get("estimatedTime").asText());
            step.setRequirements(mapper.convertValue(node.get("requirements"), List.class));
            step.setSteps(mapper.convertValue(node.get("steps"), List.class));
            step.setServiceDoc(newDoc);

            serviceStepService.saveAnalysis(step);


            model.addAttribute("analysis", step);
            model.addAttribute(userService.getUserById((Long) session.getAttribute("user_id")));

            return "analysis_result.html";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Analysis failed");
            return "analysis.html";
        }
    }
}
