package com.foodforward.WebServiceApplication.service.ngo;

import com.foodforward.WebServiceApplication.dao.ngo.NgoDonationHdrRepository;
import com.foodforward.WebServiceApplication.dao.ngo.NgoDonationLineRepository;
import com.foodforward.WebServiceApplication.model.container.foodStock.FoodStock;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoDonationContainer;
import com.foodforward.WebServiceApplication.model.container.ngo.NgoHdrContainer;
import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_hdr;

import java.time.Instant;
import java.util.*;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_line;
import com.foodforward.WebServiceApplication.model.dto.NgoDonationDto;
import com.foodforward.WebServiceApplication.service.foodStock.FoodStockService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NgoDonationService {
    private static final Log log = LogFactory.getLog(NgoDonationService.class);

    @Autowired
    private NgoHdrService ngoService;
    @Autowired
    private FoodStockService foodStockService;
    @Autowired
    private NgoDonationHdrRepository donationHdrDao;
    @Autowired
    private NgoDonationLineRepository donationLineDao;


    private NgoDonationContainer constructDonationContainer(final NgoDonationDto dto){
        ngo_donation_hdr hdr = new ngo_donation_hdr();
        final String hdrGuid = UUID.randomUUID().toString();
        hdr.setGuid(hdrGuid);
        final Optional<NgoHdrContainer> cont = ngoService.getNgoHdrContainerById(dto.getNgoGuid());
        cont.ifPresent((ngo) -> {
            hdr.setNgo_guid(ngo.getNgo_hdr().getGuid());
            hdr.setNgo_name(ngo.getNgo_hdr().getName());
            hdr.setNgo_code(ngo.getNgo_hdr().getCode());
        });
        hdr.setDonor_id(dto.getUserId());
        hdr.setDocNo(generateRandomNumber());
        hdr.setCreated_date(Instant.now().toString());
        hdr.setUpdated_date(Instant.now().toString());


        List<ngo_donation_line> lineList = new ArrayList<>();
        dto.getFoodStockGuids().forEach(fsGuid -> {
            ngo_donation_line line = new ngo_donation_line();
            line.setGuid(UUID.randomUUID().toString());
            line.setHdr_guid(hdrGuid);
            line.setCreated_date(Instant.now().toString());
            line.setUpdated_date(Instant.now().toString());
            final Optional<FoodStock> foodStock = foodStockService.getFoodStockById(fsGuid);
            foodStock.ifPresent((fs) -> {
                line.setFood_stock_guid(fs.getFood_stock_hdr().getGuid());
                line.setFood_stock_guid(fs.getFood_stock_hdr().getName());
                line.setFood_stock_guid(fs.getFood_stock_hdr().getExpiry_date());
            });
            lineList.add(line);
        });

        return new NgoDonationContainer(hdr, lineList);

    }

    public Optional<NgoDonationContainer> createDonation(final NgoDonationDto dto){
        NgoDonationContainer donationCont = constructDonationContainer(dto);
        donationHdrDao.save(donationCont.getNgo_donation_hdr());
        donationCont.getNgo_donation_lines().forEach(l -> {
            donationLineDao.save(l);
        });
        log.info("Successfully created donation ");
        return Optional.of(donationCont);
    }

    private String generateRandomNumber() {
        Random random = new Random();
        int randomNumber = 10000 + random.nextInt(1001); // Generates a number between 10000 and 11000 (inclusive)
        return String.valueOf(randomNumber);
    }
}
