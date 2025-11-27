package com.example.palguide.controllers;

import com.example.palguide.common.Models.User;
import com.example.palguide.common.enums.Role;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PageController {

    @Autowired
    UserService userService;

    @GetMapping("/request")
    public String request() {
        return "requestService.html";
    }

    @GetMapping("/dash")
    public String dash(HttpSession session, RedirectAttributes redirectAttributes) {
        if(session.getAttribute("user_id") == null) {
            redirectAttributes.addFlashAttribute("message", "You are not logged in!");
            return "redirect:/login";
        }
        User user = userService.getUserById((Long)session.getAttribute("user_id"));
        if(user.getRole() != Role.Admin){
            redirectAttributes.addFlashAttribute("message", "You are not allowed to access this page!");
            return "redirect:/home";
        }
        return "employee_dashboard.html";
    }
}
