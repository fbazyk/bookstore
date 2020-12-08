package com.realdolmen.bookstore.model;

public interface Auditable {

    Audit getAudit();

    void setAudit(Audit audit);
}
