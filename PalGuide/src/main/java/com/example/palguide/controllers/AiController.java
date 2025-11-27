package com.example.palguide.controllers;

import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.services.ServiceStepService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
public class AiController {

    @GetMapping("/analysis")
    public String analysis() {
        return "analysis.html";
    }

    @PostMapping("/analysis")
    public String analyzeDoc(@RequestParam("file") MultipartFile file, Model model) {

        ServiceStep dummy = new ServiceStep();
        dummy.setDocumentType("Teaching Certificate Renewal");

        dummy.setEstimatedTime("3–5 business days");

        dummy.setRequirements(List.of(
                "Copy of valid ID",
                "Recent personal photo (4×6)",
                "Old teaching certificate",
                "Proof of employment",
                "University degree certificate"
        ));

        dummy.setSteps(List.of(
                "Fill out the renewal form online",
                "Upload all required documents",
                "Pay the application fee using the e-payment gateway",
                "Wait for the Ministry to review your documents",
                "Download the renewed certificate once approved"
        ));

        model.addAttribute("analysis", dummy);


        return "analysis_result.html";
    }

}
