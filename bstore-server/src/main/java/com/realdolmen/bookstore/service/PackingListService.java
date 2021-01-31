package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.ArticleType;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import com.realdolmen.bookstore.repository.ArticleRepository;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class PackingListService {
    Logger logger = LoggerFactory.getLogger(PackingListService.class);
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    @Autowired
    private ArticleService articleService;

    public File generatePackingList(Order order, HttpServletResponse response) throws IOException, ArticleNotFoundException {
        logger.debug("GENERATE PACKING LIST::method triggered");
        //open workbook
        workbook = new XSSFWorkbook();
        //write header row
        this.writeHeaderLine();
        sheet = workbook.getSheet("Articles");
        int rowNumber = 1;
        for(OrderItem orderItem : order.getOrderItems()){
            Row row = sheet.createRow(rowNumber);
            //todo write data rows for each article
            Article article = this.articleService.getArticle(orderItem.getArticleType().name(), orderItem.getId());
            createDataCell(row, 0, orderItem.getArticleType().name());
            createDataCell(row, 1, orderItem.getArticleId().intValue());
            createDataCell(row, 2, article.getTitle());
            createDataCell(row, 3, orderItem.getQuantity().intValue());
            if(null != article.getLocation()){
                createDataCell(row, 4, article.getLocation().getCode());
                createDataCell(row, 5, article.getLocation().getRow());
                createDataCell(row, 6, article.getLocation().getSegment());
                createDataCell(row, 7, article.getLocation().getLevel());
            }
            rowNumber++;
        }
        for(int i=0; i<8; i++){
            sheet.autoSizeColumn(i);
        }

        //open file for writing
        File xlsx = File.createTempFile("packinglist", ".xlsx");
        try (FileOutputStream fos = new FileOutputStream(xlsx)) {
            workbook.write(fos);
            workbook.close();

        }
        return xlsx;
    }

    private void createDataCell(Row row, int columnCount, Object value) {
        Cell cell = row.createCell(columnCount);
        if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        }else {
            cell.setCellValue((String) value);
        }
    }

    private void writeHeaderLine() {
        sheet = workbook.createSheet("Articles");

        Row row = sheet.createRow(0);

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(16);
        style.setFont(font);

        createCell(row, 0, "Article Type", style);
        createCell(row, 1, "Article ID", style);
        createCell(row, 2, "Title", style);
        createCell(row, 3, "Quantity", style);
        createCell(row, 4, "Location Code", style);
        createCell(row, 5, "Row", style);
        createCell(row, 6, "Segment", style);
        createCell(row, 7, "Level", style);
//        createCell(row, 4, "", style);

        for(int i=0; i<8; i++){
            sheet.autoSizeColumn(i);
        }
    }

    private void createCell(Row row, int columnCount, Object value, CellStyle style) {
        sheet.autoSizeColumn(columnCount);
        Cell cell = row.createCell(columnCount);
        if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        }else {
            cell.setCellValue((String) value);
        }
        cell.setCellStyle(style);
    }
}
