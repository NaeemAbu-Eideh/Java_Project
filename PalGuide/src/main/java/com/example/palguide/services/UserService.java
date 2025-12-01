package com.example.palguide.services;

import com.example.palguide.common.DTO.TransactionStatusCountsDTO;
import com.example.palguide.common.DTO.UserVerifiedCountsDTO;
import com.example.palguide.common.Models.User;
import com.example.palguide.common.Models.UserLogin;
import com.example.palguide.common.enums.Role;
import com.example.palguide.common.enums.Status;
import com.example.palguide.controllers.EncryptionConverter;
import com.example.palguide.repositories.UserRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JavaMailSender mailSender;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public String login(@Valid @ModelAttribute("login") UserLogin userLogin, BindingResult bindingResult, HttpSession session, String remember,
                        HttpServletResponse response) {
        EncryptionConverter encryptionConverter = new EncryptionConverter();

        String email = encryptionConverter.convertToDatabaseColumn(userLogin.getEmail());
        User user2 = findByEmail(email);

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
            if(Objects.equals(user2.getVerified(), "PENDING") || Objects.equals(user2.getVerified(), "REJECTED")) {
                return "redirect:/login";
            }
            session.setAttribute("user_id", user2.getId());
        }
        session.setAttribute("user_id", user2.getId());

        if (remember != null) {
            Cookie cookie = new Cookie("rememberEmail", user2.getEmail());
            cookie.setMaxAge(60 * 60 * 24 * 30);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("rememberEmail", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        return "redirect:/dashboard";
    }

    public User createUser(User user, BindingResult result) {
        Optional<User> check = userRepository.findByEmail(user.getEmail());
        if (check.isPresent()) {
            result.rejectValue("email", "error", "The email is already found, chose one");
            return null;
        }
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "Matches", "The password and confirm password does not match");
            return null;
        }

        String password = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(password);
        return saveUser(user);
    }

    public User getUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    public String flush(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public boolean generateResetToken(String email) {
        EncryptionConverter encryptionConverter = new EncryptionConverter();

        String email2 = encryptionConverter.convertToDatabaseColumn(email);

        User user = findByEmail(email2);
        if (user == null) return false;


        String token = java.util.UUID.randomUUID().toString();
        user.setResetToken(token);
        userRepository.save(user);

        String resetUrl = "http://localhost:8081/reset?token=" + token;

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Password Reset Request");
            message.setText("Hello,\n\nClick the link below to reset your password:\n"
                    + resetUrl + "\n\nIf you did not request this, ignore this email.");

            mailSender.send(message);
        } catch (Exception e) {

            return false;
        }

        return true;
    }


    public User findByResetToken(String token) {
        return userRepository.findByResetToken(token).orElse(null);
    }

    public void updatePassword(User user, String newPassword) {
        String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setPassword(hashed);
        user.setResetToken(null);
        userRepository.save(user);
    }

    public List<User>findAll() {
        return userRepository.findByRole(Role.USER);
    }


    public int calculateAge(LocalDate dob) {
        return Period.between(dob, LocalDate.now()).getYears();
    }

    public UserVerifiedCountsDTO getStatusCounts() {

        Long all = userRepository.count();
        Long pending = userRepository.countByVerifiedIgnoreCase("PENDING");
        Long approved = userRepository.countByVerifiedIgnoreCase("APPROVED");
        Long rejected = userRepository.countByVerifiedIgnoreCase("REJECTED");

        return new UserVerifiedCountsDTO(all, pending, approved,rejected);
    }
}
