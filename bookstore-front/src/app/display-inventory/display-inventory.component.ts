import {ChangeDetectorRef, Component, Input, OnDestroy, OnInit, ViewChild} from '@angular/core';
import {MatTableDataSource} from "@angular/material/table";
import {MatPaginator} from "@angular/material/paginator";
import {MatTable} from '@angular/material/table';
import {MatSort} from "@angular/material/sort";
import {ArticleService} from "../service/article.service";
import {Article, Book, Game, Lp} from "../model/Articles";
import {BehaviorSubject, Subscription} from "rxjs";
import {Router} from "@angular/router";


  /** Constants used to fill up our data base. */
  const COLORS: string[] = [
    'maroon', 'red', 'orange', 'yellow', 'olive', 'green', 'purple', 'fuchsia', 'lime', 'teal',
    'aqua', 'blue', 'navy', 'black', 'gray'
  ];
  const NAMES: string[] = [
    'Maia', 'Asher', 'Olivia', 'Atticus', 'Amelia', 'Jack', 'Charlotte', 'Theodore', 'Isla', 'Oliver',
    'Isabella', 'Jasper', 'Cora', 'Levi', 'Violet', 'Arthur', 'Mia', 'Thomas', 'Elizabeth'
  ];

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
  displayedColumnsMap : Map<string, string[]> = new Map<string, string[]>();
    subscriptions: Subscription[] = [];

  @Input()
  providedType: BehaviorSubject<string>;
  // articleType: BehaviorSubject<string> = new BehaviorSubject<string>('all');

    @Input()
  articleList: Array<Article|Book|Game|Lp> = [];

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;

  constructor(private articleService: ArticleService, private router: Router) {
    this.provideDisplayedColumns();
    // // Assign the data to the data source for the table to render
    this.dataSource = new MatTableDataSource();
    this.articleService.displayedArticlesO.subscribe(value => {
      this.dataSource.data = value;
    })
    // this.dataSource.data = this.articleList;
    // let i = 0;
    // let subscription = this.articleService.displayedArticlesO.subscribe(articleList => {
    //   // console.log(i=i++)
    //   // console.log(articleList)
    //   this.dataSource.data=articleList;
    // });
    // this.subscriptions.push(subscription)
  }

    private provideDisplayedColumns() {
      this.displayedColumnsMap.set('all', ['title', 'type', 'price']);
      this.displayedColumnsMap.set('book', ['title', 'author', 'isbn', 'pages', 'price']);
      this.displayedColumnsMap.set('game', ['title', 'publisher', 'min_age', 'genre', 'price']);
      this.displayedColumnsMap.set('lp', ['title', 'artist', 'genre', 'price']);
    }

    ngOnInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
    this.dataSource.connect();


    this.providedType.subscribe(type => {
      this.displayedColumns = this.displayedColumnsMap.get(type);
    })
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

    displayArticle(article: Article) {

    console.log(article)
      this.router.navigate([ '/article', article.type, article.id])
    }

    ngOnDestroy(): void {
      this.subscriptions.forEach(subscription => subscription.unsubscribe())

    }
  }

/** Builds and returns a new User. */
function createNewUser(id: number) {
  const name = NAMES[Math.round(Math.random() * (NAMES.length - 1))] + ' ' +
    NAMES[Math.round(Math.random() * (NAMES.length - 1))].charAt(0) + '.';

  return {
    id: id.toString(),
    name: name,
    progress: Math.round(Math.random() * 100).toString(),
    color: COLORS[Math.round(Math.random() * (COLORS.length - 1))]
  };
}


