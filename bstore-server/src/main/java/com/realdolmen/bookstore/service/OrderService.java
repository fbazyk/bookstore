package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.dto.CartArticles;
import com.realdolmen.bookstore.dto.OrderItemDTO;
import com.realdolmen.bookstore.exception.ArticleNotFoundException;
import com.realdolmen.bookstore.exception.QuantityNotAvailableException;
import com.realdolmen.bookstore.model.*;
import com.realdolmen.bookstore.repository.OrderItemRepository;
import com.realdolmen.bookstore.repository.OrderRepository;
import com.realdolmen.bookstore.repository.UserRepository;
import org.hibernate.boot.model.relational.QualifiedName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.ResourceAccessException;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class OrderService {

    private OrderRepository orderRepository;
    private UserService userService;
    private ArticleService articleService;
    private OrderItemRepository orderItemRepository;
    private MockSupplierService mockSupplierService;

    Logger logger = LoggerFactory.getLogger(OrderService.class);

    public OrderService(OrderRepository orderRepository,
                        UserService userService,
                        ArticleService articleService,
                        MockSupplierService mockSupplierService,
                        OrderItemRepository orderItemRepository) {
        this.orderRepository = orderRepository;
        this.userService = userService;
        this.articleService = articleService;
        this.orderItemRepository = orderItemRepository;
        this.mockSupplierService = mockSupplierService;
    }

    /**
     * Find open order
     * where cart date <= LocalDate.now() && orderDate == null
     */
    public Order findOpenOrder() {
        //
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
        openOrder = this.saveOrder(openOrder);
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
        if (order.getOrderItems().size() == 0) {
            orderTotal = BigDecimal.ZERO;
        }
        logger.debug("OrderTotal calculated: {}", orderTotal.toString());
        return orderTotal;
    }

    @Transactional
    public Order placeOrder(User user) throws Exception {
        Order order = this.findOpenOrder();
        if (order.getOrderItems().size() > 0) {
            order.setOrderDate(Instant.now());
//            this.saveOrder(order);
            this.orderRepository.save(order);
            try {
                this.mockSupplierService.placeOrder(order);
            } catch (QuantityNotAvailableException exception) {
                order = this.orderRepository.findById(order.getOrderId()).get();
                order.setOrderDate(null);
                for (OrderItem orderItem : exception.getItemSet()) {
                    order.getOrderItems().remove(orderItem);
                }
                order.setOrderTotal(this.calcTotal(order));
                this.orderRepository.save(order);
//                this.saveOrder(order);
                throw exception;
            } catch (ResourceAccessException ex) {
                logger.debug("Exception was thrown: {}", ex.getMessage());
                throw ex;
            }
        } else throw new Exception("Order should have items");

        return order;
    }

    public boolean emptyCart() {
        Order order = this.findOpenOrder();
        this.orderRepository.delete(order);

        return true;
    }


    public Order saveOrder(Order openOrder) {
        return this.orderRepository.saveAndFlush(openOrder);
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
    public void deleteOrderItem(String articleType, Long articleId) throws Exception {

        //* Get Open Order
        Order openOrder;
        openOrder = this.findOpenOrder();

        //* Check item to delete exists
        OrderItem orderItem = openOrder.getOrderItems().stream().filter(item -> {
            return item.getArticleType().equals(ArticleType.getByType(articleType)) &&
                    item.getArticleId().equals(articleId);
        }).findFirst().orElseThrow(Exception::new);

        //* Remove item from the set
        openOrder.getOrderItems().removeIf(orderItem1 -> {
            return orderItem1.getArticleType().name().equals(articleType) &&
                    orderItem1.getArticleId().equals(articleId);
        });

        //* Save Open Order

        this.saveOrder(openOrder);
        this.orderItemRepository.delete(orderItem);
    }

    /**
     * Accept Paging data:
     * <p>
     * Cycle OrderItems from an open order
     * find each article by type and id
     */
    public CartArticles getCartArticles(Long page, Long psize) {
        Order openOrder = findOpenOrder();
        LinkedHashSet<Article> orderArticles = openOrder.getOrderItems()
                .stream()
                .map(orderItem -> {
                    try {
                        return this.articleService
                                .getArticle(orderItem.getArticleType().name(), orderItem.getArticleId());
                    } catch (ArticleNotFoundException anfex) {
                        logger.debug("Article not found {}", anfex.getMessage());
                        return null;
                    }
                }).sorted((o1, o2) -> {
                    return o1.getId().compareTo(o2.getId());
                }).collect(Collectors.toCollection(LinkedHashSet::new));
        logger.debug("GETCARTARTICLES::orderArticles size is: {}",orderArticles.size());
        logger.debug("GETCARTARTICLES::orderArticles contains null? {}",orderArticles.contains(null));
        //Page the stream
        Long offset = (page - 1) * psize;
        Set<Article> pagedArticles = Stream.of(orderArticles)
                .flatMap(Collection::stream)
                .skip(offset).limit(psize)
                .collect(Collectors.toSet());
        CartArticles resultCartArticles = new CartArticles();
        resultCartArticles.setArticles(pagedArticles);
        resultCartArticles.setTotalArticles(Stream.of(orderArticles)
                .flatMap(Collection::stream).count());
        resultCartArticles.setCurrentPage(page);
        resultCartArticles.setTotalPages((long) Math.ceil((resultCartArticles.getTotalArticles() / (double) psize)));
        return resultCartArticles;
    }
}
