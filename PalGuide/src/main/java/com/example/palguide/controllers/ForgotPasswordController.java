package com.example.palguide.controllers;

import com.example.palguide.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/forgot")
    public String showForgotPage() {
        return "forgot.html";
    }

    @PostMapping("/forgot")
    public String handleForgotRequest(@RequestParam("email") String email, Model model) {

        boolean sent = userService.generateResetToken(email);

        if (sent) {
            model.addAttribute("message", "Password reset link sent to your email.");
        } else {
            model.addAttribute("message", "Email not found.");
        }

        return "forgot.html";
    }
}
