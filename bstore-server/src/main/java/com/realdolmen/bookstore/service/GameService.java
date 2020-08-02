package com.realdolmen.bookstore.service;

import com.realdolmen.bookstore.model.Game;
import com.realdolmen.bookstore.repository.GameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public class GameService {

    private GameRepository gameRepository;

    @Autowired
    public GameService(GameRepository gameRepository){
        this.gameRepository = gameRepository;
    }

    public List<Game> findAll(){
        return this.gameRepository.findAll();
    }
}
