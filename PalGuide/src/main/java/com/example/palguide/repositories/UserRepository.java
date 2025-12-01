package com.example.palguide.repositories;

import com.example.palguide.common.Models.User;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    @Query(value = "select * from pal_guide.user where email = :email", nativeQuery = true)
    Optional<User> findByEmail(@Param("email") String email);

    @Query(value = "select * from pal_guide.user where email = :id", nativeQuery = true)
    Optional<User> findByNationalId(@Param("id") String nationalId);

    List<User> findAll();

    Optional<User> findByResetToken(String token);

}
