package com.foodforward.WebServiceApplication.repository.test;

import com.foodforward.WebServiceApplication.model.databaseSchema.test.TestUserSchema;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestRepository extends JpaRepository<TestUserSchema, Long> {
}
