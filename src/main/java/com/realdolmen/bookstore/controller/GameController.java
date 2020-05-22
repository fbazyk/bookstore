package com.realdolmen.bookstore.controller;

import com.realdolmen.bookstore.model.Game;
import com.realdolmen.bookstore.model.LP;
import com.realdolmen.bookstore.service.GameService;
import com.realdolmen.bookstore.service.LpService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
@RestController
@RequestMapping("/games")
public class GameController {


    Logger logger = LoggerFactory.getLogger(GameController.class);

    private GameService gameService;

    @Autowired
    public GameController(GameService gameService) {
        this.gameService = gameService;
    }

    @CrossOrigin
    @GetMapping
    public List<Game> findAll() {
        List<Game> result =this.gameService.findAll();
        return result;
    }
}
