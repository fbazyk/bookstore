import {Component, OnDestroy, OnInit} from '@angular/core';
import {ArticleService} from "../service/article.service";
import {BehaviorSubject, Subscription} from "rxjs";
import {MatButtonToggleChange} from "@angular/material/button-toggle";
import {Article} from "../model/Articles";
import {SearchService} from "../service/search.service";
import {provideEmptySearchState, SearchState} from "../model/SearchState";
import {UserService} from "../user.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-inventory',
  templateUrl: './inventory.component.html',
  styleUrls: ['./inventory.component.css']
})
export class InventoryComponent implements OnInit, OnDestroy {

  providedType: string;
  selectedCategory: BehaviorSubject<string>;
  // displayedArticles: Array<Article> = new Array<Article>();
  searchState: SearchState;
  newSearch: BehaviorSubject<SearchState> = new BehaviorSubject<SearchState>(provideEmptySearchState());
  showAdminControls: boolean = false;
  private subscriptions: Subscription[] = [];

  constructor(private articleService: ArticleService,
              private searchService: SearchService,
              private user: UserService,
              private router: Router) {
    console.log("INITIALIZING INVENTORY COMPONENT")
    console.log(this.searchService)
    console.log(this.searchService.searchState)
    this.selectedCategory = articleService.selectedCategory;


    // this.articleService.displayedArticlesO.subscribe(value => {
    //   this.displayedArticles = value;
    // })
  }


  ngOnInit(): void {
    //todo initiate findall call somewhere else
    //the problem: when search is active, this will wipe search-relevant data
    //how to solve?
    //


    let userSub = this.user.isAdmin().subscribe(isAdmin => {
      console.log("showing controls: {}", isAdmin)
      this.showAdminControls = isAdmin
    });
    this.subscriptions.push(userSub);

    this.articleService.findAll()
    this.articleService.selectedCategory.subscribe(category => {

    })
    this.selectedCategory.subscribe(value => this.providedType = value);
    this.searchService.searchState.subscribe(value => this.searchState = value)
    this.newSearch.subscribe(searchState => {
      //todo feed new search through request into the data display loop
      if (!!!searchState) console.log(searchState);
      if (!!searchState && !!searchState.fields) this.searchService.searchArticles(searchState);
    })
  }

  doChangeCategory(categoryChange: MatButtonToggleChange) {
    console.log("category changed just now!", categoryChange)
    //todo store.dispatch.'Inventory ArticleCategory Changed'
    if (this.articleService.selectedCategory.getValue() !== categoryChange.value) {
      this.articleService.selectedCategory.next(categoryChange.value);
    }
  }

  search($event: SearchState) {
    this.newSearch.next($event)
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(value => value.unsubscribe());
  }


  findAll() {
    this.articleService.findAll();
  }

  addArticle() {
    console.log("Going to Add an Article!!!")
    this.router.navigate(['/article'])
  }
}
