package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.ArticleRepository;
import com.realdolmen.bookstore.repository.OrderItemRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class InvoiceService {
    Logger logger = LoggerFactory.getLogger(InvoiceService.class);

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private ArticleService articleService;

    @Value("${invoice.template.path}")
    private String invoice_template;

    public File getInvoice(Order order, User user) throws IOException {
        logger.debug("Generating invoice file for order {}", order.getOrderId());
        //TODO get article title into the object
        List<Article> articles = this.articleService.findAll();
        ArrayList<OrderItemReportDTO> oirds = new ArrayList<>();
        List<OrderItemReportDTO> list = order.getOrderItems().stream().map(orderItem -> {
            OrderItemReportDTO result = new OrderItemReportDTO(orderItem);
            result.setTitle(articles.stream().filter(article -> {
                return (article.getClass().getSimpleName().toUpperCase().equals(orderItem.getArticleType().name())) &&
                        article.getId().equals(orderItem.getArticleId());
            }).findFirst().map(Article::getTitle).get());
            return result;
        }).collect(Collectors.toList());

        ArrayList<OrderItem> orderItems = new ArrayList<>(order.getOrderItems());
//        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(orderItems);
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(list);

        Map<String, Object> parameters = new HashMap<>(Map.ofEntries(Map.entry("order", order)));
        parameters.put("createdBy", "Fedor");
        parameters.put("USER", user);
        parameters.put("ORDER", order);

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
