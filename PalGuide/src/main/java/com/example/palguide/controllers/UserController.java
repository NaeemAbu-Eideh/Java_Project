package com.example.palguide.controllers;

import com.example.palguide.common.Models.UserLogin;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String index(@ModelAttribute("login") UserLogin userLogin, HttpSession session) {
        if(session.getAttribute("user_id") != null) {
            return "redirect:/home";
        }
        return "index.html";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("login") UserLogin userLogin, BindingResult result, HttpSession session) {
        return userService.login(userLogin,result,session);
    }
}
