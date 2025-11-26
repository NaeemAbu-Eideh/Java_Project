package com.example.palguide.services;

import com.example.palguide.common.Models.User;
import com.example.palguide.common.Models.UserLogin;
import com.example.palguide.repositories.UserRepository;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public String login(@Valid @ModelAttribute("login") UserLogin userLogin, BindingResult bindingResult, HttpSession session) {
        User user2 = findByEmail(userLogin.getEmail());

        if (bindingResult.hasErrors()) {
            return "login.html";
        }

        if (user2 == null) {
            bindingResult.rejectValue("email", "error", "The email or password is incorrect");
            return "login.html";
        } else {
            if (!BCrypt.checkpw(userLogin.getPassword(), user2.getPassword())) {
                bindingResult.rejectValue("password", "Matches", "The email or password is incorrect");
                return "login.html";
            }
            session.setAttribute("user_id", user2.getId());
        }
        return "redirect:/dashboard";
    }
}
