package com.example.palguide.common.Models;

import com.example.palguide.controllers.EncryptionConverter;
import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
public class UserLogin {

    @Convert( converter = EncryptionConverter.class)
    @Setter
    @Size(max = 255)
    @NotBlank(message = UserMessage.NOTBLANK)
    @Email(message = UserMessage.EMAIL)
    @Column(name = "email", nullable = false)
    private String email;


    @Setter
    @NotBlank(message = UserMessage.NOTBLANK)
    @Size(min = 8, message = UserMessage.PASSWORD)
    private String password;

}
