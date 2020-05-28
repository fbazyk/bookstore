package com.realdolmen.bookstore;

import com.realdolmen.bookstore.controller.ArticleController;
import com.realdolmen.bookstore.model.Article;
import com.realdolmen.bookstore.service.ArticleService;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;

@SpringBootTest
class DemoApplicationTests {

	Logger logger = LoggerFactory.getLogger(DemoApplicationTests.class);


	@Autowired
	ArticleService articleService;

	@Test
	void contextLoads() {
	}

	@Test
	void emptySearchEqualsFindAll(){
		//todo test
		logger.debug("gotta test search and findall");

		ArrayList<Article> findAllResults =  new ArrayList<>(this.articleService.findAll());
		ArrayList<Article> emptySearchResults =  new ArrayList<>(this.articleService.search(null));

	}

}
