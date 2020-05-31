import { Component, OnInit } from '@angular/core';
import {ArticleService} from "../service/article.service";
import {BehaviorSubject} from "rxjs";
import {MatButtonToggleChange} from "@angular/material/button-toggle";
import {Article} from "../model/Articles";
import {SearchService} from "../service/search.service";
import {provideEmptySearchState, SearchState} from "../model/SearchState";

@Component({
  selector: 'app-inventory',
  templateUrl: './inventory.component.html',
  styleUrls: ['./inventory.component.css']
})
export class InventoryComponent implements OnInit {

providedType: string;
  selectedCategory: BehaviorSubject<string>;
  // displayedArticles: Array<Article> = new Array<Article>();
  searchState: SearchState;
  newSearch: BehaviorSubject<SearchState> = new BehaviorSubject<SearchState>(provideEmptySearchState());

  constructor(private articleService: ArticleService, private searchService: SearchService) {
    console.log("INITIALIZING INVENTORY COMPONENT")
    console.log(this.searchService)
    console.log(this.searchService.searchState)
    this.selectedCategory = articleService.selectedCategory;
    this.selectedCategory.subscribe(value => this.providedType = value);
    this.searchService.searchState.subscribe(value => this.searchState = value)
    this.newSearch.subscribe(searchState => {
      //todo feed new search through request into the data display loop
      if(!!!searchState && searchState.engaged) console.log(searchState);
      if(!!searchState && searchState.engaged && !!searchState.fields) this.searchService.searchArticles(searchState);
    })
    // this.articleService.displayedArticlesO.subscribe(value => {
    //   this.displayedArticles = value;
    // })
  }



  ngOnInit(): void {
    //todo initiate findall call somewhere else
    //the problem: when search is active, this will wipe search-relevant data
    //how to solve?
    //
    this.articleService.findAll()
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
