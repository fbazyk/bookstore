package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.model.Order;
import com.realdolmen.bookstore.model.OrderItem;
import com.realdolmen.bookstore.model.User;
import com.realdolmen.bookstore.repository.OrderItemRepository;
import com.realdolmen.bookstore.repository.OrderRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.Instant;

@Component
public class OrderService {

    private OrderRepository orderRepository;
    private UserService userService;
    private ArticleService articleService;
    private OrderItemRepository orderItemRepository;

    Logger logger = LoggerFactory.getLogger(OrderService.class);

    public OrderService(OrderRepository orderRepository,
                        UserService userService,
                        ArticleService articleService,
                        OrderItemRepository orderItemRepository) {
        this.orderRepository = orderRepository;
        this.userService = userService;
        this.articleService = articleService;
        this.orderItemRepository = orderItemRepository;
    }

    /**
     * Find open order
     */
    public Order findOpenOrder() {
        //TODO find an order where cart date <= LocalDate.now() && orderDate == null
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();

        }
        logger.debug(username);
        User currentUser = this.userService.findByUserName(username);

        Order openOrder = this.orderRepository.findOrdersByOrderDateIsNullAndUser(currentUser);
        if (openOrder == null) {
            openOrder = openOrder(currentUser);
        }
        return openOrder;
    }

    /**
     * Open order/create cart for
     *
     * @param user Open Order is an order with cartDate and no orderDate
     */

    public Order openOrder(User user) {
        Order openOrder = new Order();
        openOrder.setUser(user);
        openOrder.setCartDate(Instant.now());
        logger.debug("OpenOrder executed {}", openOrder.getOrderId());
        return openOrder;
    }

    /**
     * Calc Total
     * Loop through the orderItems, add to the total
     */
    public BigDecimal calcTotal(Order order) {
        BigDecimal orderTotal = new BigDecimal(0);
        for (OrderItem item : order.getOrderItems()) {
            orderTotal = orderTotal.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }
        logger.debug("OrderTotal calculated: {}", orderTotal.toString());
        return orderTotal;
    }


    public void saveOrder(Order openOrder) {
        this.orderRepository.saveAndFlush(openOrder);
    }

    /**
     * Add/update Order Item
     * Check Article Exists, otherwise throw Exception
     * Check open order exists
     * Check order has same article already, then add quantity
     * Check quantity is positive, if negative set quantity to 1
     * Else create OrderItem and add to the open order
     */

    public void addUpdateOrderItem(OrderItemDTO orderItemDTO) {

        Article articleToOrder = null;
        Order openOrder;
        OrderItem itemToAdd = new OrderItem();
        try {
            //find article by type and id
            articleToOrder = this.articleService.findByTypeAndId(orderItemDTO.getArticleType(), orderItemDTO.getArticleId());

        } catch (Exception exception) {
            logger.debug("Article Not Found", exception);
        }

        openOrder = this.findOpenOrder();

        final Article finalArticleToOrder = articleToOrder;
        //check openOrderItems if the item already exists
        openOrder.getOrderItems().stream().filter(existingItem -> {
            return existingItem.getArticleType().equals(orderItemDTO.getArticleType()) &&
                    existingItem.getArticleId().equals(orderItemDTO.getArticleId());
        })
                //if exists - add quantity & save
                .findFirst().ifPresentOrElse(presentItem -> {
            // Check quantity is positive, if negative set quantity to 1
            if (orderItemDTO.getQuantity() >= 1l) {
                presentItem.setQuantity(orderItemDTO.getQuantity());
            } else {
                presentItem.setQuantity(1l);
            }
        }, () -> {
            // Else create OrderItem and add to the open order
            itemToAdd.setArticleType(orderItemDTO.getArticleType());
            itemToAdd.setArticleId(finalArticleToOrder.getId());
            itemToAdd.setQuantity(orderItemDTO.getQuantity());
            itemToAdd.setPrice(finalArticleToOrder.getPrice());
            openOrder.getOrderItems().add(itemToAdd);
        });

        openOrder.setOrderTotal(this.calcTotal(openOrder));
        this.saveOrder(openOrder);
        logger.debug("addUpdateOrderItem executed");

    }


    /**
     * Delete OrderItem
     * Get Open Order
     * Check item to delete exists
     * Remove item from the set
     * Save Open Order
     */
    public void deleteOrderItem(OrderItemDTO orderItemDTO) throws Exception {

        //* Get Open Order
        Order openOrder;
        openOrder = this.findOpenOrder();

        //* Check item to delete exists
        OrderItem orderItem = openOrder.getOrderItems().stream().filter(item -> {
            return item.getArticleType().equals(orderItemDTO.getArticleType()) &&
                    item.getArticleId().equals(orderItemDTO.getArticleId());
        }).findFirst().orElseThrow(Exception::new);

        //* Remove item from the set
        openOrder.getOrderItems().removeIf(orderItem1 -> {
            return orderItem1.getArticleType().equals(orderItemDTO.getArticleType()) &&
                    orderItem1.getArticleId().equals(orderItemDTO.getArticleId());
        });

        //* Save Open Order

        this.saveOrder(openOrder);
        this.orderItemRepository.delete(orderItem);
    }


}
