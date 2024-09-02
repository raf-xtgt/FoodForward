package com.foodforward.WebServiceApplication.service.test;
import com.foodforward.WebServiceApplication.model.databaseSchema.test.TestUserSchema;
import com.foodforward.WebServiceApplication.repository.test.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service

public class TestService {

    @Autowired
    private TestRepository userRepository;

    public TestUserSchema saveUser(TestUserSchema user) {
        return userRepository.save(user);
    }
}
