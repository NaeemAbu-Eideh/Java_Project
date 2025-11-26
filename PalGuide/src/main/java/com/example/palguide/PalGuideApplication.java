package com.example.palguide;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.thymeleaf.spring6.SpringTemplateEngine;
import org.thymeleaf.spring6.view.ThymeleafViewResolver;

@SpringBootApplication
public class PalGuideApplication {

    public static void main(String[] args) {
        SpringApplication.run(PalGuideApplication.class, args);
    }


    // JSP resolver
    @Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/");
        resolver.setOrder(2);
        resolver.setViewNames("*.jsp");
        return resolver;
    }

}
