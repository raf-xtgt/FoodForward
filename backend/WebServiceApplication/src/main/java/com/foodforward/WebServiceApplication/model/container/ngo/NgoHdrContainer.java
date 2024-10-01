package com.foodforward.WebServiceApplication.model.container.ngo;

import com.foodforward.WebServiceApplication.model.databaseSchema.ngo.ngo_hdr;

public class NgoHdrContainer {
    private final ngo_hdr ngo_hdr;

    public NgoHdrContainer(ngo_hdr ngo_hdr) {
        this.ngo_hdr = ngo_hdr;
    }
    public NgoHdrContainer() {
        this.ngo_hdr = new ngo_hdr();
    }

    public ngo_hdr getNgo_hdr() {
        return ngo_hdr;
    }
}
