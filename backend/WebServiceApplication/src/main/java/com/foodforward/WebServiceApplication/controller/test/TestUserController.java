package com.foodforward.WebServiceApplication.controller.test;

import com.foodforward.WebServiceApplication.model.databaseSchema.test.TestUserSchema;
import com.foodforward.WebServiceApplication.service.test.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/test")
public class TestUserController {

    @Autowired
    private TestService userService;

    @PostMapping("/create")
    public TestUserSchema addUser(@RequestBody TestUserSchema user) {
        return userService.saveUser(user);
    }
    // Retrieve a specific TestUser by ID
    @GetMapping("/{id}")
    public ResponseEntity<TestUserSchema> getTestUserById(@PathVariable Long id) {
        Optional<TestUserSchema> testUser = userService.getTestUserById(id);
        return testUser.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Update a TestUser
    @PutMapping("/{id}")
    public ResponseEntity<TestUserSchema> updateTestUser(@PathVariable Long id, @RequestBody TestUserSchema testUserDetails) {
        TestUserSchema updatedTestUser = userService.updateTestUser(id, testUserDetails);
        if (updatedTestUser != null) {
            return ResponseEntity.ok(updatedTestUser);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete a TestUser by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTestUser(@PathVariable Long id) {
        userService.deleteTestUser(id);
        return ResponseEntity.noContent().build();
    }
}
