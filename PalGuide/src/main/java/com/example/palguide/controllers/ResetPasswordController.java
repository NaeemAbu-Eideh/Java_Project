package com.example.palguide.controllers;

import com.example.palguide.common.Models.User;
import com.example.palguide.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ResetPasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/reset")
    public String showResetPage(@RequestParam("token") String token, Model model) {

        User user = userService.findByResetToken(token);

        if (user == null) {
            model.addAttribute("error", "Invalid or expired reset token.");
            return "reset.html";
        }

        model.addAttribute("token", token);
        return "reset.html";
    }

    @PostMapping("/reset")
    public String handleReset(
            @RequestParam String token,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            Model model) {

        User user = userService.findByResetToken(token);

        if (user == null) {
            model.addAttribute("error", "Invalid token.");
            return "reset.html";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("token", token);
            return "reset.html";
        }

        userService.updatePassword(user, password);
        return "redirect:/login?resetSuccess";
    }
}
