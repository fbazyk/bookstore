package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Audit;
import com.realdolmen.bookstore.model.Auditable;

import javax.persistence.PostUpdate;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import java.time.LocalDateTime;

public class AuditListener {

    private UserService userService;

    public AuditListener(UserService userService) {
        this.userService = userService;
    }

    public AuditListener() {
    }

    @PrePersist
    public void setCreatedOn(Auditable auditable) {
        Audit audit = auditable.getAudit();

        if(audit == null) {
            audit = new Audit();
            auditable.setAudit(audit);
        }

        audit.setCreatedOn(LocalDateTime.now());
        audit.setCreatedBy(userService.currentUserName());
    }

    @PreUpdate
    public void setUpdatedOn(Auditable auditable) {
        Audit audit = auditable.getAudit();

        if(audit == null) {
            audit = new Audit();
            auditable.setAudit(audit);
        }
        audit.setUpdatedOn(LocalDateTime.now());
        audit.setUpdatedBy(userService.currentUserName());
    }
}
