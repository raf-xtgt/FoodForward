package com.foodforward.WebServiceApplication.model.container.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_donation_hdr;

public class NgoDonationHdrContainer {
    private final ngo_donation_hdr ngo_donation_hdr;

    public NgoDonationHdrContainer(ngo_donation_hdr ngo_donation_hdr) {
        this.ngo_donation_hdr = ngo_donation_hdr;
    }
    public NgoDonationHdrContainer() {
        this.ngo_donation_hdr = new ngo_donation_hdr();
    }

    public ngo_donation_hdr getNgo_donation_hdr() {
        return ngo_donation_hdr;
    }
}
