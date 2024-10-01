package com.foodforward.WebServiceApplication.service.ngo;

import com.foodforward.WebServiceApplication.dao.ngo.NgoDonationHdrRepository;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoDonationHdrContainer;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class NgoDonationHdrService {
    @Autowired
    private NgoDonationHdrRepository dao;
    private static final Log log = LogFactory.getLog(NgoDonationHdrService.class);

    public Optional<NgoDonationHdrContainer> createNgoDonationHdrContainer(final NgoDonationHdrContainer cont){
        dao.save(cont.getNgo_donation_hdr());
        log.info("Successfully created ngo donation hdr");
        return Optional.of(cont);
    }

    public Optional<NgoDonationHdrContainer> updateNgoDonationHdrContainer(final NgoDonationHdrContainer ngoHdr){
        dao.save(ngoHdr.getNgo_donation_hdr());
        log.info("Successfully updated ngo");
        return Optional.of(ngoHdr);
    }

    public Optional<NgoDonationHdrContainer> getNgoDonationHdrContainerById(final String ngoHdrId){
        try{
            return dao.findByGuid(ngoHdrId).stream().map(NgoDonationHdrContainer::new).findFirst();
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<NgoDonationHdrContainer>> getAllNgoDonationHdrContainerHdrs(){
        try{
            List<NgoDonationHdrContainer> ngoHdrList = dao.findAll().stream().map(NgoDonationHdrContainer::new).toList();
            return Optional.of(ngoHdrList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<NgoDonationHdrContainer>> getNgoDonationsByNgoId(final String ngoId){
        try{
            List<NgoDonationHdrContainer> ngoHdrList = dao.getByNgoId(ngoId).stream().map(NgoDonationHdrContainer::new).toList();
            return Optional.of(ngoHdrList);
        }
        catch(Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<String> deleteNgoDonationHdrContainer(final String ngoHdrId){
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
