import { Component, OnInit } from '@angular/core';
import {ArticleService} from "../service/article.service";
import {BehaviorSubject} from "rxjs";
import {MatButtonToggleChange} from "@angular/material/button-toggle";
import {Article} from "../model/Articles";

@Component({
  selector: 'app-inventory',
  templateUrl: './inventory.component.html',
  styleUrls: ['./inventory.component.css']
})
export class InventoryComponent implements OnInit {

providedType: string;
  selectedCategory: BehaviorSubject<string>;
  displayedArticles: Array<Article> = new Array<Article>();

  constructor(private articleService: ArticleService) {
    this.articleService.selectedCategory.subscribe(value => this.providedType = value);
    this.selectedCategory = articleService.selectedCategory;
    this.articleService.displayedArticlesO.subscribe(value => {
      this.displayedArticles = value;
    })
  }



  ngOnInit(): void {
    this.articleService.findAll()


      //todo send request according to the value

      // A view component shouldn't be doing any requests. let the service do it
      //

      //todo where do i put the case switch?

    this.articleService.selectedCategory.subscribe(category => {

    })
  }

  doChangeCategory(categoryChange: MatButtonToggleChange){
    console.log("category changed just now!", categoryChange)
    //todo store.dispatch.'Inventory ArticleCategory Changed'
    if(this.articleService.selectedCategory.getValue() !== categoryChange.value){
      this.articleService.selectedCategory.next(categoryChange.value);
    }
  }

}
