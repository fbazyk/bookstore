package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.CartArticles;
import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.model.OrdersDTO;
import com.realdolmen.bookstore.service.*;
import net.sf.jasperreports.engine.JRException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.ResourceAccessException;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import static java.lang.String.format;
import static org.springframework.http.HttpStatus.OK;
import static org.springframework.http.MediaType.APPLICATION_OCTET_STREAM;
import static org.springframework.http.MediaType.APPLICATION_PDF;


@CrossOrigin(origins = "http://localhost:4201")
@RestController
public class OrderController {

    private OrderService orderService;
    private ArticleService articleService;
    private UserService userService;
    private InvoiceService invoiceService;
    private PackingListService packingListService;

    private Logger logger = LoggerFactory.getLogger(OrderController.class);

    public OrderController(OrderService orderService,
                           ArticleService articleService,
                           UserService userService,
                           InvoiceService invoiceService,
                           PackingListService packingListService) {
        this.orderService = orderService;
        this.articleService = articleService;
        this.userService = userService;
        this.invoiceService = invoiceService;
        this.packingListService = packingListService;
    }

    /**
     * Get Cart
     * */
    @GetMapping(path = "/cart")
    public ResponseEntity<Order> getCart(){
        Order openOrder;
        try {
            openOrder= this.orderService.findOpenOrder();
            return ResponseEntity.ok(openOrder);
        } catch (Exception exception){
            logger.debug("GET CART::Something went wrong {}", exception.getMessage());
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).build();
        }
    }

    @GetMapping(path = "/cartarticles")
    public ResponseEntity<CartArticles> getCartArticles(@RequestParam Long page, @RequestParam Long psize){
        CartArticles cartArticles;
        try{
            cartArticles = this.orderService.getCartArticles(page, psize);
        } catch (Exception ex){
            logger.debug("CARTARTICLES::something went wrong: {}", ex.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        return ResponseEntity.ok(cartArticles);
    }

    @GetMapping(path="/orders")
    public ResponseEntity<OrdersDTO> getUserOrders(){
        OrdersDTO ordersDTO = new OrdersDTO();

         ordersDTO.setOrderList(this.orderService.getUserOrders(this.userService.currentUser()));
        return ResponseEntity.status(HttpStatus.OK).body(ordersDTO);
    }

    @GetMapping(path="/orders/new")
    public ResponseEntity<OrdersDTO> getNewOrders(){
        OrdersDTO ordersDTO = new OrdersDTO();

         ordersDTO.setOrderList(this.orderService.getNewOrders());
        return ResponseEntity.status(HttpStatus.OK).body(ordersDTO);
    }
    @GetMapping(path="/orders/plist/{id}")
    public ResponseEntity<InputStreamResource>  getPackingList(HttpServletResponse response, @PathVariable Long id) throws Exception {
        logger.debug("GET PACKING LIST::method triggered");
        Order order = this.orderService.getOrderById(id);
        HttpHeaders respHeaders = new HttpHeaders();
        File packingList = this.packingListService.generatePackingList(order, response);
        respHeaders.setContentType(APPLICATION_OCTET_STREAM);
        respHeaders.setContentLength(packingList.length());
        respHeaders.setContentDispositionFormData("attachment", format("packinglist-%s.xlsx", id));
        return new ResponseEntity<>(new InputStreamResource(new FileInputStream(packingList)), respHeaders , OK);
    }

    @GetMapping(path="/orders/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id){
        Order order = this.orderService.getUserOrderById(this.userService.currentUser(), id);
        return ResponseEntity.status(HttpStatus.OK).body(order);
    }

    @GetMapping(path = "/orders/invoice/{id}", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<InputStreamResource> getInvoiceFor(@PathVariable long id) throws IOException, JRException {
        User currentUser = this.userService.currentUser();
        if(currentUser.getAddress()==null || currentUser.getAddress().getId()==null){
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).build();
        }
        Order order = new Order();
        File invoiceFile = new File("invoice.pdf");
        try {
            order = this.orderService.findOrderById(id);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        if(order.getUser().getId().equals(currentUser.getId())){
            invoiceFile = this.invoiceService.getInvoice(order, currentUser);
        }
        logger.debug("Get invoice for order {}", id);
        return new ResponseEntity<>(new InputStreamResource(new FileInputStream(invoiceFile)), getHttpHeaders("1", "en", invoiceFile), OK);

//        return ResponseEntity.ok().headers(getHttpHeaders(order.getOrderId().toString(), "en", invoiceFile)).body(invoiceFile);
    }

    private HttpHeaders getHttpHeaders(String code, String lang, File invoicePdf) {
        HttpHeaders respHeaders = new HttpHeaders();
        respHeaders.setContentType(APPLICATION_PDF);
        respHeaders.setContentLength(invoicePdf.length());
        respHeaders.setContentDispositionFormData("attachment", format("%s-%s.pdf", code, lang));
        return respHeaders;
    }

    /**
     * Add/update order item
     */
    @PostMapping(path = "/orderitem")
    public ResponseEntity<Boolean> addOrderItem(@RequestBody OrderItemDTO orderItemDTO) {
        try{
            this.orderService.addUpdateOrderItem(orderItemDTO);
            return ResponseEntity.ok(true);
        } catch (Exception exception) {
            logger.debug("ADD ORDERITEM::Something went wrong {}", exception.getMessage());
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(false);
        }
    }

    /**
     * Post: SetQuantity
     * accepts OrderItemDTO, sets quantity
     * */

    /**
     * Delete order item
     * */
    @DeleteMapping(path = "/orderitem/{type}/{id}")
    public ResponseEntity<Boolean> deleteOrderItem(@PathVariable String type, @PathVariable long id){
        try{
            this.orderService.deleteOrderItem(type, id);
            return ResponseEntity.ok(true);
        } catch (Exception exception) {
            logger.debug("DELETE ORDERITEM::Something went wrong {}", exception.getMessage());
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(false);
        }
    }

    @PostMapping(path = "/order")
    public ResponseEntity<Boolean> placeOrder(){
        Object principal = SecurityContextHolder.getContext().getAuthentication(). getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        com.realdolmen.bookstore.model.User foundUser = this.userService.findByUserName(username);
        try{
            this.orderService.placeOrder(foundUser);
            return ResponseEntity.ok(true);

        } catch (QuantityNotAvailableException ex){
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(false);
        } catch(ResourceAccessException ex){
            return ResponseEntity.status(HttpStatus.CONFLICT).body(false);
        }
        catch (Exception ex){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }

    }

    @DeleteMapping (path = "/order")
    public ResponseEntity<Boolean> emptyCart(){
        this.orderService.emptyCart();
        return ResponseEntity.ok(true);
    }

}
//TODO if there is no order => create order with cartDate = today
//TODO add item to the existing order if there is an order with cartDate and no orderDate
//TODO remove item from order
//TODO show all orders for the user
//TODO show open order = with cartDate and no orderDate



