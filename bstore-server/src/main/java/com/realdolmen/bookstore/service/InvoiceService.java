package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;

@Service
public class InvoiceService {
    Logger logger = LoggerFactory.getLogger(InvoiceService.class);


    @Value("${invoice.template.path}")
    private String invoice_template;

    public File getInvoice(Order order) throws IOException {
        logger.debug("Generating invoice file for order {}", order.getOrderId());


        File pdfFile = File.createTempFile("my-invoice", ".pdf");

        logger.info(String.format("Invoice pdf path : %s", pdfFile.getAbsolutePath()));

        try(FileOutputStream pos = new FileOutputStream(pdfFile))
        {
            // Load invoice JRXML template.
            final JasperReport report = loadTemplate();

            // Fill parameters map.
            final Map<String, Object> parameters = Map.ofEntries(Map.entry("order", order));

            // Create an empty datasource.
            ArrayList<OrderItem> orderItems = new ArrayList<>(order.getOrderItems());
            final JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(orderItems);

            // Render the invoice as a PDF file.
            JasperReportsUtils.renderAsPdf(report, parameters, dataSource, pos);

            // return file.
            return pdfFile;
        }
        catch (final Exception e)
        {
            logger.error(String.format("An error occured during PDF creation: %s", e));
            throw new RuntimeException(e);
        }
    }

    private JasperReport loadTemplate() throws JRException {

        logger.info(String.format("Invoice template path : %s", invoice_template));

        final InputStream reportInputStream = getClass().getResourceAsStream(invoice_template);
        final JasperDesign jasperDesign = JRXmlLoader.load(reportInputStream);

        return JasperCompileManager.compileReport(jasperDesign);
    }
}
