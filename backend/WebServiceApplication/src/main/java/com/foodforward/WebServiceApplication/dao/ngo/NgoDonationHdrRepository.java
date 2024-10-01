package com.foodforward.WebServiceApplication.dao.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_hdr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;


@Repository
public interface NgoDonationHdrRepository extends JpaRepository<ngo_donation_hdr, UUID> {

    @Query("SELECT u FROM ngo_donation_hdr u WHERE u.guid = :donationId")
    List<ngo_donation_hdr> findByGuid(@Param("donationId") String donationId);

    @Query("SELECT u FROM ngo_donation_hdr u WHERE u.ngo_guid = :ngoId")
    List<ngo_donation_hdr> getByNgoId(@Param("ngoId") String ngoId);

    @Modifying
    @Transactional
    @Query("DELETE FROM ngo_donation_hdr u WHERE u.guid = :donationId")
    void deleteByGuid(@Param("donationId") String donationId);

}
