package com.example.palguide.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    @GetMapping("/sign-up")
    public String signUpPage() {
        return "register.jsp";
    }
}
