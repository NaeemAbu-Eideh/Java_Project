package com.example.palguide.controllers;

import com.example.palguide.common.Models.ServiceStep;
import com.example.palguide.common.Models.User;
import com.example.palguide.services.AiAnalysisService;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AiController {

  @Autowired
  AiAnalysisService aiAnalysisService;

  @Autowired
  UserService userService;

  @GetMapping("/analysis")
  public String analysis(Model model, RedirectAttributes attributes, HttpSession session) {
    if (session.getAttribute("user_id") == "-1") {
      session.removeAttribute("user_id");
    }
    if (session.getAttribute("user_id") == null) {
      attributes.addFlashAttribute("message", "You are not logged in");
      return "redirect:/login";
    }
    model.addAttribute("user", userService.getUserById((Long) session.getAttribute("user_id")));
    return "analysis.html";
  }

  @PostMapping("/analysis")
  public String analyze(@RequestParam("file") MultipartFile file, Model model, HttpSession session) {
    if (session.getAttribute("user_id") == "-1") {
      session.removeAttribute("user_id");
    }
    if (session.getAttribute("user_id") == null) {
      return "redirect:/login";
    }

    User user = userService.getUserById((Long) session.getAttribute("user_id"));
    if (user == null) {
      session.removeAttribute("user_id");
      return "redirect:/login";
    }

    try {
      ServiceStep step = aiAnalysisService.analyzeDocument(file);

      model.addAttribute("analysis", step);
      model.addAttribute("user", user);

      return "analysis_result.html";

    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute("error", "Analysis failed");
      model.addAttribute("user", user);
      return "analysis.html";
    }
  }
}
