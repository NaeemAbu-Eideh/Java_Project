package com.example.palguide.controllers;

import com.example.palguide.common.DTO.TransactionStatusCountsDTO;
import com.example.palguide.common.Models.Transaction;
import com.example.palguide.common.Models.User;
import com.example.palguide.common.enums.Role;
import com.example.palguide.common.enums.Status;
import com.example.palguide.services.TransactionService;
import com.example.palguide.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;


@Controller
public class PagesController {

    @Autowired
    UserService userService;
    @Autowired
    private TransactionService transactionService;

    @GetMapping("/")
    public String dashboardAtFirst(HttpSession httpSession) {


        if (httpSession.getAttribute("user_id") == "-1") {
            httpSession.removeAttribute("user_id");
        }
        if (httpSession.getAttribute("user_id") != null) {
            return "redirect:/dashboard";
        }
        return "landing_page.jsp";
    }

    @GetMapping("/dashboard")
    public String dashboard(
            Model model,
            HttpSession session
    ) {

        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/";
        }
        User user = userService.getUserById((Long) session.getAttribute("user_id"));

        model.addAttribute("user", user);
        return "landing_page.jsp";
    }

    @GetMapping("/dashboard/logout")
    public String logout(HttpSession session) {
        return userService.flush(session);
    }


    @GetMapping("/start-request")
    public String startRequest(HttpSession session) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/login";
        }
        return "redirect:/request";
    }


    @GetMapping("/request")
    public String request(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/login";
        }

        User user = (userService.getUserById((Long) session.getAttribute("user_id")));
        if (user.getRole() != Role.USER) {
            return "redirect:/dashboard";
        }

        return "requestService.html";
    }

    @GetMapping("/dash/api")
    @ResponseBody
    public List<Transaction> dashApi(
            @RequestParam(value = "status", required = false) String status,
            HttpSession session
    ) {
        if (session.getAttribute("user_id") == null) {
            return null;
        }
        Long id = (Long) session.getAttribute("user_id");

        return switch (status) {
            case "ALL" -> transactionService.getAllTransactions();
            case "PENDING" -> transactionService.getTransactionsByStatus(Status.PENDING);
            case "IN_PROGRESS" -> transactionService.getTransactionsByStatus(Status.UNDER_REVIEW);
            case "COMPLETED" -> transactionService.getTransactionsByStatus(Status.COMPLETED);
            case "REJECTED" -> transactionService.getTransactionsByStatus(Status.REJECTED);
            default -> List.of();
        };
    }


    @GetMapping("/dash")
    public String dash(HttpSession session, RedirectAttributes redirectAttributes, Model model, @RequestParam(value = "status", required = false) String status) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            redirectAttributes.addFlashAttribute("message", "You are not logged in!");
            return "redirect:/login";
        }
        User user = userService.getUserById((Long) session.getAttribute("user_id"));
        if (user.getRole() != Role.Admin && user.getRole() != Role.Gov) {
            redirectAttributes.addFlashAttribute("message", "You are not allowed to access this page!");
            return "redirect:/home";
        }
        TransactionStatusCountsDTO counts = transactionService.getStatusCounts();

        model.addAttribute("counts", counts);
        model.addAttribute("transaction", transactionService.getAllTransactions());

        return "employee_dashboard.html";
    }

    @GetMapping("/about-us")
    public String aboutUs(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/login";
        }
        User user = userService.getUserById((Long) session.getAttribute("user_id"));
        model.addAttribute("user", user);
        return "about_us.jsp";
    }

    @GetMapping("/my-requests")
    public String myRequests(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == "-1") {
            session.removeAttribute("user_id");
        }
        if (session.getAttribute("user_id") == null) {
            return "redirect:/login";
        }
        User user = userService.getUserById((Long) session.getAttribute("user_id"));
        model.addAttribute("user", user);
        return "my_requests.jsp";
    }
}
