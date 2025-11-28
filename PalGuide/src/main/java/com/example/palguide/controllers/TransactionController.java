package com.example.palguide.controllers;

import com.example.palguide.common.Models.Transaction;
import com.example.palguide.common.enums.Payment;
import com.example.palguide.common.enums.Status;
import com.example.palguide.common.enums.Type;
import com.example.palguide.services.TransactionService;
import com.example.palguide.services.UserService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TransactionController {
    @Autowired
    TransactionService transactionService;
    @Autowired
    UserService userService;

    @Value("${stripe.api.key}")
    private String apiKey;

    @PostConstruct
    public void init() {
        Stripe.apiKey = apiKey;
    }

    @PostMapping("/request-service")
    public String requestService(
            @RequestParam("type") String typeString,
            @RequestParam(value = "notes", required = false) String notes,
            HttpSession session
    ) {

        Long userId = (Long) session.getAttribute("user_id");
        if (userId == null) {
            return "redirect:/login";
        }
        Type type = Type.valueOf(typeString);
        Transaction t = new Transaction();

        t.setType(type);
        t.setTitle(type.getDisplayName());
        t.setAmount(type.getAmount());

        if (notes != null && !notes.trim().isEmpty()) {
            t.setDescription(notes);
        } else {
            t.setDescription("Request for " + type.getDisplayName());
        }

        t.setStatus(Status.PENDING);
        t.setPaymentStatus(Payment.NOT_PAID);

        t.setUser(userService.getUserById(userId));

        transactionService.saveTransaction(t);

        return "redirect:/payment/create?transactionId=" + t.getId();
    }


    @GetMapping("/payment/create")
    public String createPayment(@RequestParam Long transactionId) throws StripeException {

        Transaction t = transactionService.getTransactionById(transactionId);
        SessionCreateParams params = SessionCreateParams.builder()
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl("http://localhost:8081/payment/success?tid=" + transactionId + "&session_id={CHECKOUT_SESSION_ID}")
                .setCancelUrl("http://localhost:8081/payment/cancel")
                .addLineItem(
                        SessionCreateParams.LineItem.builder()
                                .setQuantity(1L)
                                .setPriceData(
                                        SessionCreateParams.LineItem.PriceData.builder()
                                                .setCurrency("usd")
                                                .setUnitAmount(t.getAmount() * 100)
                                                .setProductData(
                                                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                .setName(t.getTitle())
                                                                .build()
                                                )
                                                .build()
                                )
                                .build()
                )
                .build();

        Session session = Session.create(params);

        return "redirect:" + session.getUrl();
    }

    @GetMapping("/payment/success")
    public String success(@RequestParam Long tid, @RequestParam("session_id") String sessionId) throws StripeException {

        Session session = Session.retrieve(sessionId);

        if (!"paid".equals(session.getPaymentStatus())) {
            return "redirect:/payment/cancel";
        }

        Transaction t = transactionService.getTransactionById(tid);
        t.setPaymentStatus(Payment.PAID);
        t.setStatus(Status.UNDER_REVIEW);
        transactionService.saveTransaction(t);

        return "payment_success.html";
    }


    @GetMapping("/payment/cancel")
    public String cancel() {
        return "payment_cancel.html";
    }


}
