package com.foodforward.WebServiceApplication.dao.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_hdr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Repository
public interface NgoHdrRepository extends JpaRepository<ngo_hdr, UUID> {

    @Query("SELECT u FROM ngo_hdr u WHERE u.guid = :ngoId")
    List<ngo_hdr> findByGuid(@Param("ngoId") String ngoId);

    @Modifying
    @Transactional
    @Query("DELETE FROM ngo_hdr u WHERE u.guid = :ngoId")
    void deleteByGuid(@Param("ngoId") String ngoId);

}
