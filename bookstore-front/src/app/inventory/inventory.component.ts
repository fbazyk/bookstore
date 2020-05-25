import { Component, OnInit } from '@angular/core';
import {ArticleService} from "../service/article.service";

@Component({
  selector: 'app-inventory',
  templateUrl: './inventory.component.html',
  styleUrls: ['./inventory.component.css']
})
export class InventoryComponent implements OnInit {

  constructor(private articleService: ArticleService) { }

  ngOnInit(): void {
    this.articleService.selectedCategory.subscribe(category => {
      switch (category) {
        case "all": {
          //send request
          //provide response to the sub-components
          //select sub-components
          //
        }

      }
    })
  }

}
