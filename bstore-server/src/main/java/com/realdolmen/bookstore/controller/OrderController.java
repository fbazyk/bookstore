package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4201")
@RestController
public class OrderController {

    private OrderService orderService;
    private ArticleService articleService;
    private Logger logger = LoggerFactory.getLogger(OrderController.class);

    public OrderController(OrderService orderService,
                           ArticleService articleService) {
        this.orderService = orderService;
        this.articleService = articleService;
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
     * Delete order item
     * */
    @DeleteMapping(path = "/orderitem")
    public ResponseEntity<Boolean> deleteOrderItem(@RequestBody OrderItemDTO orderItemDTO){
        try{
            this.orderService.deleteOrderItem(orderItemDTO);
            return ResponseEntity.ok(true);
        } catch (Exception exception) {
            logger.debug("DELETE ORDERITEM::Something went wrong {}", exception.getMessage());
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(false);
        }
    }


}
//TODO if there is no order => create order with cartDate = today
//TODO add item to the existing order if there is an order with cartDate and no orderDate
//TODO remove item from order
//TODO show all orders for the user
//TODO show open order = with cartDate and no orderDate



