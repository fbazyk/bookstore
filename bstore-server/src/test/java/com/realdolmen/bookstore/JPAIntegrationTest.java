package com.realdolmen.bookstore;

import com.realdolmen.bookstore.model.GenericEntity;
import com.realdolmen.bookstore.repository.GenericEntityRepository;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.springframework.test.util.AssertionErrors.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BookstoreApplication.class)
@ContextConfiguration(classes = BookstoreApplication.class)
public class JPAIntegrationTest {

    Logger logger = LoggerFactory.getLogger(JPAIntegrationTest.class);

    @Autowired
    private GenericEntityRepository genericEntityRepository;

    @Test
    public void givenGenericEntityRepository_whenSaveAndRetreiveEntity_thenOK() {
        GenericEntity entityToSave = new GenericEntity("test");
        GenericEntity genericEntity = genericEntityRepository.save(entityToSave);
        GenericEntity foundEntity = genericEntityRepository.getOne(genericEntity.getId());
        List<GenericEntity> foundEntity2 = genericEntityRepository.findAll();

        foundEntity2.forEach(genericEntity1 -> {
            logger.debug(genericEntity1.getValue());
        });

        Assert.assertNotNull(foundEntity);
        Assert.assertEquals(genericEntity.getValue(), foundEntity.getValue());
    }
}
