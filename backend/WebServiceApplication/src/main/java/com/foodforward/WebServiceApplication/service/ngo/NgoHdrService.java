package com.foodforward.WebServiceApplication.service.ngo;

import com.foodforward.WebServiceApplication.dao.ngo.NgoHdrRepository;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoHdrContainer;
import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_hdr;
import com.foodforward.WebServiceApplication.model.dto.NgoDto;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class NgoHdrService {
    @Autowired
    private NgoHdrRepository dao;
    private static final Log log = LogFactory.getLog(NgoHdrService.class);

    public NgoHdrContainer constructNgoHdrFromDto(final NgoDto dto){
        ngo_hdr hdr =new ngo_hdr();
        hdr.setGuid(UUID.randomUUID().toString());
        hdr.setName(dto.getName());
        hdr.setCode(dto.getCode());
        hdr.setDescription(dto.getDesc());
        hdr.setCreated_date(Instant.now().toString());
        hdr.setUpdated_date(Instant.now().toString());
        return new NgoHdrContainer(hdr);
    }

    public Optional<NgoHdrContainer> createNgoHdrContainer(final NgoDto dto){
        NgoHdrContainer ngoHdr = constructNgoHdrFromDto(dto);
        dao.save(ngoHdr.getNgo_hdr());
        log.info("Successfully created ngo");
        return Optional.of(ngoHdr);
    }

    public Optional<NgoHdrContainer> updateNgoHdrContainer(final NgoHdrContainer ngoHdr){
        dao.save(ngoHdr.getNgo_hdr());
        log.info("Successfully updated ngo");
        return Optional.of(ngoHdr);
    }

    public Optional<NgoHdrContainer> getNgoHdrContainerById(final String ngoHdrId){
        try{
            return dao.findByGuid(ngoHdrId).stream().map(NgoHdrContainer::new).findFirst();
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<NgoHdrContainer>> getAllNgoHdrContainerHdrs(){
        try{
            List<NgoHdrContainer> ngoHdrList = dao.findAll().stream().map(NgoHdrContainer::new).toList();
            return Optional.of(ngoHdrList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<String> deleteNgoHdrContainer(final String ngoHdrId){
        try{
            dao.deleteByGuid(ngoHdrId);
            log.info("Successfully deleted ngo");
            return Optional.of(ngoHdrId);
        }
        catch(Exception e){
            log.error("OCR queue deletion");
            return Optional.empty();
        }
    }
}
