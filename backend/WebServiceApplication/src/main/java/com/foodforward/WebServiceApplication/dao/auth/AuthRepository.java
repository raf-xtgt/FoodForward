package com.foodforward.WebServiceApplication.dao.auth;


import com.foodforward.WebServiceApplication.model.databaseSchema.auth.user_profile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

import java.util.UUID;

@Repository
public interface AuthRepository extends JpaRepository<user_profile, UUID> {

    // JPQL query to find users by name
    @Query("SELECT u FROM user_profile u WHERE u.firebase_id = :firebaseId")
    List<user_profile> findProfileByFirebaseId(@Param("firebaseId") String firebaseId);

    @Query("SELECT u FROM user_profile u WHERE u.guid = :userId")
    List<user_profile> findProfileById(@Param("userId") String userId);

}
