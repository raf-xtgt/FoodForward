package com.foodforward.WebServiceApplication.dao.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_line;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;


@Repository
public interface NgoDonationLineRepository extends JpaRepository<ngo_donation_line, UUID> {

    @Query("SELECT u FROM ngo_donation_line u WHERE u.guid = :lineId")
    List<ngo_donation_line> findByGuid(@Param("lineId") String lineId);

    @Query("SELECT u FROM ngo_donation_line u WHERE u.hdr_guid = :ngoHdrId")
    List<ngo_donation_line> getByNgoHdrId(@Param("ngoHdrId") String ngoHdrId);

    @Modifying
    @Transactional
    @Query("DELETE FROM ngo_donation_line u WHERE u.guid = :lineId")
    void deleteByGuid(@Param("lineId") String lineId);

}
