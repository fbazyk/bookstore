package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Order;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Service
public class PackingListService {
    Logger logger = LoggerFactory.getLogger(PackingListService.class);
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    public void generatePackingList(Order order, HttpServletResponse response) throws IOException {
        logger.debug("GENERATE PACKING LIST::method triggered");
        workbook = new XSSFWorkbook();
        this.writeHeaderLine();
        //TODO open file for writing
        //TODO open workbook
        //todo write header row
        //TODO prepare the data for writing
        //todo write data rows for each article

        //TODO return written file

        //TODO Optional: add data for StorageLocation
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();

        outputStream.close();

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
        createCell(row, 4, "Location", style);
//        createCell(row, 4, "", style);

        for(int i=0; i<5; i++){
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
