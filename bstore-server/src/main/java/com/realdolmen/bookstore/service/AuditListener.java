package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Audit;
import com.realdolmen.bookstore.model.Auditable;
import com.realdolmen.bookstore.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.PostUpdate;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import java.time.LocalDateTime;

@Component
public class AuditListener {

    private static UserService userService;

    @Autowired
    public void setUserService (UserService service) {
        this.userService=service;
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
