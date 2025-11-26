package com.example.palguide.controllers;

import com.example.palguide.common.Models.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class PageController {
    @GetMapping("/sign-up")
    public String signUpPage(
            @ModelAttribute("register") User user
    ) {
        return "register.jsp";
    }
}
