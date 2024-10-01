package com.foodforward.WebServiceApplication.model.container.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_hdr;
import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_line;

import java.util.ArrayList;
import java.util.List;

public class NgoDonationContainer {
    private final ngo_donation_hdr ngo_donation_hdr;
    private final List<ngo_donation_line> ngo_donation_lines;

    public NgoDonationContainer(ngo_donation_hdr ngo_donation_hdr, List<ngo_donation_line> ngo_donation_lines) {
        this.ngo_donation_hdr = ngo_donation_hdr;
        this.ngo_donation_lines = ngo_donation_lines;
    }

    public NgoDonationContainer() {
        this.ngo_donation_hdr = new ngo_donation_hdr();
        this.ngo_donation_lines = new ArrayList<>();
    }

    public ngo_donation_hdr getNgo_donation_hdr() {
        return ngo_donation_hdr;
    }

    public List<ngo_donation_line> getNgo_donation_lines() {
        return ngo_donation_lines;
    }
}
