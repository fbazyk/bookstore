import {ChangeDetectorRef, Component, Inject, InjectionToken, Input, OnDestroy, OnInit, ViewChild} from '@angular/core';
import {MatTableDataSource} from "@angular/material/table";
import {MatPaginator, MatPaginatorDefaultOptions} from "@angular/material/paginator";
import {MatTable} from '@angular/material/table';
import {MatSort, Sort} from "@angular/material/sort";
import {ArticleService} from "../service/article.service";
import {Article, Book, Game, Lp} from "../model/Articles";
import {BehaviorSubject, Subscription} from "rxjs";
import {Router} from "@angular/router";
import {UserService} from "../user.service";
import {ArticlesPage} from "../model/ArticlesPage";

/**
 * @title Data table with sorting, pagination, and filtering.
 */
@Component({
  selector: 'app-display-inventory',
  templateUrl: './display-inventory.component.html',
  styleUrls: ['./display-inventory.component.css'],
})
export class DisplayInventoryComponent implements OnInit, OnDestroy {
  displayedColumns: string[] = ['id', 'title', 'type', 'price'];
  dataSource: MatTableDataSource<Article>;
  totalArticles: number = 0;
  currentPage: number = 1;
  totalPages: number;
  displayedColumnsMap: Map<string, string[]> = new Map<string, string[]>();
  private subscriptions: Subscription[] = [];
  paginationOptions: MatPaginatorDefaultOptions = {
    pageSize: 9,
    pageSizeOptions: [10, 20],
    showFirstLastButtons: true,
    hidePageSize: false,
  }
  showAdminControls: boolean = false;


  @Input()
  providedType: BehaviorSubject<string>;
  // articleType: BehaviorSubject<string> = new BehaviorSubject<string>('all');

  @Input()
  articleList: Array<Article | Book | Game | Lp> = [];

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;

  ngOnInit() {
    // this.dataSource.paginator = this.paginator;
    // this.dataSource.sort = this.sort;
    // this.dataSource.paginator.pageSize = 5;
    // this.dataSource.connect();
    // this.articleService.findCategoryFilteredPaged(
    //   this.articleService.selectedCategory.value,
    //   this.articleService.filterValue.value,
    //   this.articleService.pageRequest.value.pageSize,
    //   this.articleService.pageRequest.value.pageIndex
    // )
    let articlesSub = this.articleService.pagedArticles.subscribe((value:ArticlesPage) => {
      console.log(value);
      if(!!value){
        this.dataSource.data = value.articles;
        this.totalArticles = value.totalArticles;
        this.currentPage = value.currentPage-1;
        this.totalPages = value.totalPages;
      } else {
        console.log(value)
      }

    })
    let typeSub = this.providedType.subscribe(type => {
      this.displayedColumns = this.displayedColumnsMap.get(type);
    })
    let paginatorSub = this.paginator.page.subscribe(value => {
      this.articleService.pageRequest.next({pageIndex: value.pageIndex+1, pageSize: this.paginator.pageSize })
    })
    this.subscriptions.push(paginatorSub);
    this.subscriptions.push(articlesSub);
    this.subscriptions.push(typeSub);

  }

  constructor(public articleService: ArticleService, private router: Router,
  ) {

    this.provideDisplayedColumns();
    // // Assign the data to the data source for the table to render
    this.dataSource = new MatTableDataSource();

    // this.articleService.displayedArticlesO.subscribe(value => {
    //   this.dataSource.data = value;
    // })

  }

  sortData(sort: Sort) {
    console.log(sort)
  }

  private provideDisplayedColumns() {
    this.displayedColumnsMap.set('all', ['title', 'type', 'price']);
    this.displayedColumnsMap.set('book', ['title', 'author', 'isbn', 'pages', 'price']);
    this.displayedColumnsMap.set('game', ['title', 'publisher', 'min_age', 'genre', 'price']);
    this.displayedColumnsMap.set('lp', ['title', 'artist', 'genre', 'price']);
  }

  ngAfterViewInit(){
    this.paginator.page.subscribe(value => {
      // console.log(value)
      // this.articleService.findPaged(value.pageIndex+1, this.dataSource.paginator.pageSize)
    })
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.articleService.filterValue.next(filterValue);
    // this.dataSource.filter = filterValue.trim().toLowerCase();
    //
    // if (this.dataSource.paginator) {
    //   this.dataSource.paginator.firstPage();
    // }
  }

  displayArticle(article: Article) {
    this.router.navigate(['/article', article.type, article.id])
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(subscription => subscription.unsubscribe())

  }

  getNext($event){
    console.log($event)
    if(!!$event) {

      // this.articleService.findPaged($event.pageIndex+1, $event.pageSize)
    }
  }
}
