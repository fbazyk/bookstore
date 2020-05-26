import { Component, OnInit } from '@angular/core';
import {ArticleService} from "../service/article.service";
import {BehaviorSubject} from "rxjs";
import {MatButtonToggleChange} from "@angular/material/button-toggle";

@Component({
  selector: 'app-inventory',
  templateUrl: './inventory.component.html',
  styleUrls: ['./inventory.component.css']
})
export class InventoryComponent implements OnInit {

providedType: string;
  selectedCategory: BehaviorSubject<string>;

  constructor(private articleService: ArticleService) {
    this.providedType = articleService.selectedCategory.getValue();
    this.selectedCategory = articleService.selectedCategory;
  }



  ngOnInit(): void {


      //todo send request according to the value

      // A view component shouldn't be doing any requests. let the service do it
      //

      //todo where do i put the case switch?

    this.articleService.selectedCategory.subscribe(category => {

    })
  }

  doChangeCategory(categoryChange: MatButtonToggleChange){
    //todo store.dispatch.'Inventory ArticleCategory Changed'
    this.articleService.selectedCategory.next(categoryChange.value);
  }

}
