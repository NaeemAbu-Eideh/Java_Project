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
import java.util.Optional;

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
        session.setAttribute("user_id", user2.getId());
        return "redirect:/dashboard";
    }

    public User createUser(User user, BindingResult result) {
        Optional<User> check = userRepository.findByEmail(user.getEmail());
        if (check.isPresent()) {
            result.rejectValue("email", "error", "The email is already found, chose one");
            return null;
        }
        System.out.println("password " + user.getConfirmPassword());
        if(!user.getPassword().equals(user.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "Matches", "The password and confirm password does not match");
            return null;
        }
        System.out.println("naeem");
        System.out.println("password " + user.getConfirmPassword());
        String password =  BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(password);
        return saveUser(user);
    }

    public  User getUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    public String flush(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    public User saveUser(User user){
        return userRepository.save(user);
    }
}
