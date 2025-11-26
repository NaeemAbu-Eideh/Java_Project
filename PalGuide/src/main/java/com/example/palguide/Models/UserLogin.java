package com.example.palguide.Models;

import jakarta.persistence.Column;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserLogin {

    @Size(max = 255)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Email(message = UserMessage.EMAIL)
    @Column(name = "email", nullable = false)
    private String email;

    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.PASSWORD)
    private String password;

}
