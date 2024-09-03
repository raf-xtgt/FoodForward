package com.foodforward.WebServiceApplication.service.test;
import com.foodforward.WebServiceApplication.model.databaseSchema.test.TestUserSchema;
import com.foodforward.WebServiceApplication.repository.test.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service

public class TestService {

    @Autowired
    private TestRepository userRepository;

    public TestUserSchema saveUser(TestUserSchema user) {
        return userRepository.save(user);
    }

    // Retrieve a specific TestUser by ID
    public Optional<TestUserSchema> getTestUserById(Long id) {
        return userRepository.findById(id);
    }

    // Update an existing TestUser
    public TestUserSchema updateTestUser(Long id, TestUserSchema testUserDetails) {
        Optional<TestUserSchema> existingTestUser = userRepository.findById(id);
        if (existingTestUser.isPresent()) {
            TestUserSchema testUser = existingTestUser.get();
            testUser.setEmail(testUserDetails.getEmail());
            testUser.setName(testUserDetails.getName());
            return userRepository.save(testUser);
        } else {
            return null; // or throw an exception if not found
        }
    }

    // Delete a TestUser by ID
    public void deleteTestUser(Long id) {
        userRepository.deleteById(id);
    }
}
