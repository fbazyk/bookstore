package com.realdolmen.bookstore.tools;

import com.realdolmen.bookstore.model.UserRole;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.AttributeConverter;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class RoleAttributeConverter implements AttributeConverter<String, UserRole> {
    Logger logger = LoggerFactory.getLogger(RoleAttributeConverter.class);

    @Override
    public UserRole convertToDatabaseColumn(String s) {
        logger.debug("String to convert {}", s);
        return UserRole.valueOf(s);
    }

    @Override
    public String convertToEntityAttribute(UserRole userRole) {
        logger.debug("String to convert {}", userRole);
        return userRole.toString();
    }
}
