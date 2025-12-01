package com.example.palguide.controllers;

import ch.qos.logback.core.model.Model;
import com.example.palguide.common.DTO.TransactionStatusCountsDTO;
import com.example.palguide.common.DTO.UserVerifiedCountsDTO;
import com.example.palguide.common.Models.User;
import com.example.palguide.common.enums.Role;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class AdminController {
    @Autowired
    UserService userService;

    @GetMapping("/admin")
    public String admin(HttpSession session, org.springframework.ui.Model model) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/login";
        }
        User user = userService.getUserById((Long) session.getAttribute("user_id"));
        if(user.getRole() != Role.Admin) {
            return "redirect:/dashboard";
        }
        UserVerifiedCountsDTO counts = userService.getStatusCounts();

        model.addAttribute("counts", counts);
        model.addAttribute("user", user);
        model.addAttribute("users",userService.findAll());
        return "admin_dashboard.html";
    }

    @GetMapping("/admin/users/approve/{id}")
    public String approve(@PathVariable long id, Model model,HttpSession session) {
        User checkAdmin =userService.getUserById((long) session.getAttribute("user_id"));
        if(checkAdmin.getRole() != Role.Admin) {
            return "redirect:/dashboard";
        }
        User user = userService.getUserById(id);
        user.setVerified("APPROVED");
        userService.saveUser(user);
        return "redirect:/admin";
    }

    @GetMapping("/admin/users/reject/{id}")
    public String reject(@PathVariable long id, Model model,HttpSession session) {
        User checkAdmin =userService.getUserById((long) session.getAttribute("user_id"));
        if(checkAdmin.getRole() != Role.Admin) {
            return "redirect:/dashboard";
        }
        User user = userService.getUserById(id);

        user.setVerified("REJECTED");
        userService.saveUser(user);
        return "redirect:/admin";
    }


}
