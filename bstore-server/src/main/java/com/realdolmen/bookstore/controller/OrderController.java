package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import com.realdolmen.bookstore.service.ArticleService;
import com.realdolmen.bookstore.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

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
     * Add order item
     * Check Article Exists, otherwise throw Exception
     * Check open order exists
     * Check order has same article already, then add quantity
     * Else create OrderItem and add to the open order
     */
    @PostMapping(path = "/addorderitem")
    public void addOrderItem(@RequestBody OrderItemDTO orderItemDTO) {
        //TODO find article by type and id
        Article articleToOrder = null;
        Order openOrder;
        OrderItem itemToAdd = new OrderItem();
        try {
            articleToOrder = this.articleService.findByTypeAndId(orderItemDTO.getArticleType(), orderItemDTO.getArticleId());

        } catch (Exception exception) {
            logger.debug("Article Not Found", exception);
        }

        openOrder = this.orderService.findOpenOrder();

        final Article finalArticleToOrder = articleToOrder;
        //check openOrderItems if the item already exists
        openOrder.getOrderItems().stream().filter(existingItem -> {
            return existingItem.getArticleType().equals(orderItemDTO.getArticleType()) &&
                    existingItem.getArticleId().equals(orderItemDTO.getArticleId());
        })
                //if exists - add quantity & save
                .findFirst().ifPresentOrElse(presentItem -> {
            presentItem.setQuantity(presentItem.getQuantity() + orderItemDTO.getQuantity());
        }, () -> {
            //else populate item to add
            itemToAdd.setArticleType(orderItemDTO.getArticleType());
            itemToAdd.setArticleId(finalArticleToOrder.getId());
            itemToAdd.setQuantity(orderItemDTO.getQuantity());
            itemToAdd.setPrice(finalArticleToOrder.getPrice());

        });
        openOrder.getOrderItems().add(itemToAdd);
        this.orderService.saveOrder(openOrder);
        logger.debug("addOrderItem executed");
    }


}
//TODO if there is no order => create order with cartDate = today
//TODO add item to the existing order if there is an order with cartDate and no orderDate
//TODO remove item from order
//TODO show all orders for the user
//TODO show open order = with cartDate and no orderDate



