package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.CartArticles;
import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.model.UserOrdersDTO;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.InvoiceService;
import com.realdolmen.bookstore.service.OrderService;
import com.realdolmen.bookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.ResourceAccessException;

import java.io.File;
import java.io.IOException;


@CrossOrigin(origins = "http://localhost:4201")
@RestController
public class OrderController {

    private OrderService orderService;
    private ArticleService articleService;
    private UserService userService;
    private InvoiceService invoiceService;

    private Logger logger = LoggerFactory.getLogger(OrderController.class);

    public OrderController(OrderService orderService,
                           ArticleService articleService,
                           UserService userService,
                           InvoiceService invoiceService) {
        this.orderService = orderService;
        this.articleService = articleService;
        this.userService = userService;
        this.invoiceService = invoiceService;
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
    public ResponseEntity<UserOrdersDTO> getUserOrders(){
        UserOrdersDTO userOrdersDTO = this.orderService.getUserOrders(this.userService.currentUser());
        return ResponseEntity.status(HttpStatus.OK).body(userOrdersDTO);
    }

    @GetMapping(path = "/orders/invoice/{id}", produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<File> getInvoiceFor(@PathVariable long id)throws IOException {
        User currentUser = this.userService.currentUser();
        Order order = new Order();
        File invoiceFile = new File("invoice.pdf");
        try {
            order = this.orderService.findOrderById(id);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        if(order.getUser().getId().equals(currentUser.getId())){
            invoiceFile = this.invoiceService.getInvoice(order);
        }
        logger.debug("Get invoice for order {}", id);
        return ResponseEntity.ok(invoiceFile);
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
        //TODO in OrderService: placeOrder
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



