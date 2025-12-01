package com.example.palguide.controllers;

import com.example.palguide.common.Models.Address;
import com.example.palguide.common.Models.User;
import com.example.palguide.common.Models.UserLogin;
import com.example.palguide.services.AddressService;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;


@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private AddressService addressService;


    @GetMapping("/login")
    public String index(@CookieValue(value = "rememberEmail", required = false) String rememberedEmail, @ModelAttribute("login") UserLogin userLogin, HttpSession session, Model model) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") != null) {
            return "redirect:/dashboard";
        }
        UserLogin login = new UserLogin();
        login.setEmail(rememberedEmail); // autofill if exists
        model.addAttribute("login", login);
        return "login.html";
    }

    @PostMapping("/login/signin")
    public String login(@Valid @ModelAttribute("login") UserLogin userLogin, BindingResult result, HttpSession session, @RequestParam(required = false) String remember,
                        HttpServletResponse response) {
        return userService.login(userLogin, result, session, remember, response);
    }

    @GetMapping("/sign-up/step1")
    public String signUpPageStep1(
            @ModelAttribute("register") User user,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }

        if (session.getAttribute("user_id") != null) {
            if (session.getAttribute("step2") == null) {
                return "redirect:/dashboard";
            }
        }
        return "register_step1.jsp";
    }

    @GetMapping("/sign-up/step1/next")
    public String returnPageStep1Next() {
        return "redirect:/sign-up/step1";
    }

    @PostMapping("/sign-up/step1/next")
    public String goPageStepNext(
            @Valid @ModelAttribute("register") User user,
            BindingResult result,
            HttpSession session
    ) {
        if (result.hasErrors()) {
            return "register_step1.jsp";
        }

        LocalDate today = LocalDate.now();

        if (user.getDob().isAfter(today)) {
            result.rejectValue("dob", "error", "the date must not be in the future");
            return "register_step1.jsp";
        }

        int age = userService.calculateAge(user.getDob());

        if(age < 16){
            result.rejectValue("dob", "error", "the age must be 16 or older");
            return "register_step1.jsp";
        }

        EncryptionConverter encryptionConverter = new EncryptionConverter();
        String email = encryptionConverter.convertToDatabaseColumn(user.getEmail());

        User target = userService.findByEmail(email);
        if(target != null){
            result.rejectValue("email", "error", "the email already exists");
            return "register_step1.jsp";
        }

        session.setAttribute("user_id", -1);
        session.setAttribute("fname", user.getFirstname());
        session.setAttribute("lname", user.getLastname());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("dob", user.getDob());
        session.setAttribute("password", user.getPassword());
        session.setAttribute("nid", user.getNationalId());
        session.setAttribute("conpass", user.getConfirmPassword());
        session.setAttribute("phone", user.getPhone());
        session.removeAttribute("step2");
        return "redirect:/sign-up/step2";
    }

    @GetMapping("/sign-up/step2")
    public String signUpPageStep2(
            @ModelAttribute("address") Address address,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == null) {
            return "redirect:/dashboard";
        }
        return "register_step2.jsp";
    }

    @GetMapping("/sign-up/step2/back")
    public String returnPageStep2back(
            HttpSession session
    ) {
        session.setAttribute("step2", "step2");
        return "redirect:/sign-up/step1";
    }

    @GetMapping("/sign-up/step2/register")
    public String returnToPageStep2Next() {
        return "redirect:/sign-up/step2";
    }

    @PostMapping("/sign-up/step2/register")
    public String returnPageStep1Next(
            @Valid @ModelAttribute("address") Address address,
            BindingResult result,
            HttpSession session
    ) {
        if (result.hasErrors()) {
            return "register_step2.jsp";
        }
        User user = new User();
        user.setFirstname(session.getAttribute("fname").toString());
        user.setLastname(session.getAttribute("lname").toString());
        user.setEmail(session.getAttribute("email").toString());
        user.setPassword(session.getAttribute("password").toString());
        user.setDob((LocalDate) session.getAttribute("dob"));
        user.setPhone(session.getAttribute("phone").toString());
        user.setNationalId(session.getAttribute("nid").toString());
        user.setConfirmPassword(session.getAttribute("conpass").toString());
        User target = userService.createUser(user, result);
        address.setUser(target);
        addressService.saveAddress(address);
        session.setAttribute("user_id", target.getId());
        return "redirect:/dashboard";
    }

    @GetMapping("/{name}/profile")
    public String profilePageStep1(
            @ModelAttribute("user") User user,
            @ModelAttribute("address") Address address,
            @PathVariable("name") String name,
            HttpSession session,
            Model model
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/";
        }
        User target = userService.getUserById((Long) session.getAttribute("user_id"));
        model.addAttribute("user", target);
        return "profile_page.jsp";
    }


    @GetMapping("/{name}/profile/logout")
    public String logoutPage(
            @PathVariable("name") String name,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        return userService.flush(session);
    }

    @GetMapping("/flush")
    public String flush(HttpSession session) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/{name}/profile/add-address")
    public String addAddressPageStep(
            @PathVariable("name") String name,
            @ModelAttribute("address") Address address,
            @ModelAttribute("user") User user,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        return "redirect:/" + name + "/profile";
    }

    @PostMapping("/{name}/profile/add-address")
    public String addAddressPageStep1(
            @PathVariable("name") String name,
            @Valid @ModelAttribute("address") Address address,
            BindingResult result,
            @ModelAttribute("user") User user,
            HttpSession session
    ) {
        if (result.hasErrors()) {
            return "profile_page.jsp";
        }
        User target = userService.getUserById((Long) session.getAttribute("user_id"));
        address.setUser(target);
        addressService.saveAddress(address);
        return "redirect:/" + name + "/profile";
    }

    @GetMapping("/{name}/profile/edit")
    public String editPageStep1(
            @PathVariable("name") String name,
            @Valid @ModelAttribute("address") Address address,
            @ModelAttribute("user") User user,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        return "redirect:/" + name + "/profile";
    }

    @PostMapping("/{name}/profile/edit")
    public String editPageStep2(
            @PathVariable("name") String name,
            @ModelAttribute("address") Address address,
            @Valid @ModelAttribute("user") User user,
            BindingResult result,
            HttpSession session
    ) {
        if (result.hasErrors()) {
            return "profile_page.jsp";
        }
        User target = userService.getUserById((Long) session.getAttribute("user_id"));
        target.setFirstname(user.getFirstname());
        target.setLastname(user.getLastname());
        target.setPhone(user.getPhone());
        userService.saveUser(target);
        return "redirect:/" + name + "/profile";
    }

    @GetMapping("/{name}/profile/upload-image")
    public String returnToProfilePage(
            @PathVariable("name") String name,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        return "redirect:/" + name + "/profile";
    }

    @PostMapping("/{name}/profile/upload-image")
    public String uploadImage(
            @RequestParam("profileImage") MultipartFile profileImage,
            @PathVariable("name") String name,
            HttpSession session
    ) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId == null) {
            return "redirect:/login";
        }

        User target = userService.getUserById(userId);
        target.setConfirmPassword(target.getPassword());

        try {
            if (profileImage != null && !profileImage.isEmpty()) {
                target.setProfileImage(profileImage.getBytes());
            }
            userService.saveUser(target);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/" + name + "/profile";
    }

    @GetMapping("/user/{id}/image")
    public void getUserImage(HttpSession session, @PathVariable("id") Long id, HttpServletResponse response) throws IOException {
        User user = userService.getUserById(id);

        if (session.getAttribute("user_id") == null || session.getAttribute("user_id") == "-1" || user == null || user.getProfileImage() == null) {
            return;
        }
        response.setContentType("image/jpeg"); // or png depending on what you upload
        response.getOutputStream().write(user.getProfileImage());
        response.getOutputStream().close();
    }
}
