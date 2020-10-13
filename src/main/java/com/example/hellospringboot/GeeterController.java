package com.example.hellospringboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * GeeterController
 */
@RestController
public class GeeterController {

    @GetMapping
    public String hello() {
        return "Hi SpringBoot";
    }

}
