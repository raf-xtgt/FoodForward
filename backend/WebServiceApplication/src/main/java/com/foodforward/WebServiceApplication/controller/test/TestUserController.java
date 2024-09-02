package com.foodforward.WebServiceApplication.controller.test;

import com.foodforward.WebServiceApplication.model.databaseSchema.test.TestUserSchema;
import com.foodforward.WebServiceApplication.service.test.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class TestUserController {

    @Autowired
    private TestService userService;

    @PostMapping
    public TestUserSchema addUser(@RequestBody TestUserSchema user) {
        return userService.saveUser(user);
    }
}
