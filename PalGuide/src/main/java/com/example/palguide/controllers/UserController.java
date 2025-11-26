package com.example.palguide.controllers;

import com.example.palguide.common.Models.Address;
import com.example.palguide.common.Models.User;
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

    @GetMapping("/login")
    public String index(@ModelAttribute("login") UserLogin userLogin, HttpSession session) {
        if(session.getAttribute("user_id") != null) {
            return "redirect:/home";
        }
        return "login.html";
    }

    @PostMapping("/login/signin")
    public String login(@Valid @ModelAttribute("login") UserLogin userLogin, BindingResult result, HttpSession session) {
        return userService.login(userLogin,result,session);
    }

    @GetMapping("/sign-up/step1")
    public String signUpPageStep1(
            @ModelAttribute("register") User user
    ) {
        return "register_step1.jsp";
    }

    @GetMapping("/sign-up/step1/next")
    public String returnPageStep1Next(){
        return "redirect:/sign-up/step1";
    }

    @PostMapping("/sign-up/step1/next")
    public String goPageStepNext(
            @Valid @ModelAttribute("register") User user,
            BindingResult result,
            HttpSession session
    ){
        if(result.hasErrors()){
            return "register_step1.jsp";
        }
        return "redirect:/sign-up/step2";
    }

    @GetMapping("/sign-up/step2")
    public String signUpPageStep2(
            @ModelAttribute("address") Address address,
            HttpSession session
            ) {
        return "register_step2.jsp";
    }

    @GetMapping("/sign-up/step2/register")
    public String returnPageStep1Next(
            @Valid @ModelAttribute("address") Address address,
            BindingResult result,
            HttpSession session
    ){
        if(result.hasErrors()){
            return "register_step2.jsp";
        }

        return "redirect:/sign-up/step2";
    }
}
