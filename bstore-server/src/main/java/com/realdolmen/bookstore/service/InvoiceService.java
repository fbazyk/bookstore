package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.jasperreports.JasperReportsUtils;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Service
public class InvoiceService {
    Logger logger = LoggerFactory.getLogger(InvoiceService.class);


    @Value("${invoice.template.path}")
    private String invoice_template;

    public File getInvoice(Order order) throws IOException{
        logger.debug("Generating invoice file for order {}", order.getOrderId());
        ArrayList<OrderItem> orderItems = new ArrayList<>(order.getOrderItems());
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(orderItems);

        Map<String, Object> parameters = new HashMap<>(Map.ofEntries(Map.entry("order", order)));
        parameters.put("createdBy", "Fedor");

        //load file and compile it
        File file = ResourceUtils.getFile("classpath:reports/test_template.jrxml");

        File pdf = File.createTempFile("invoice", ".pdf");

        try (FileOutputStream fos = new FileOutputStream(pdf)) {
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, fos);
        } catch (final Exception e) {
            logger.error(String.format("An error occured during PDF creation: %s", e));
            logger.error("Exception: {}", e.getMessage());
            throw new RuntimeException(e);
        }
        return pdf;
    }
}
