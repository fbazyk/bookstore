import {ChangeDetectorRef, Component, Input, OnInit, ViewChild} from '@angular/core';
import {MatTableDataSource} from "@angular/material/table";
import {MatPaginator} from "@angular/material/paginator";
import {MatTable} from '@angular/material/table';
import {MatSort} from "@angular/material/sort";
import {ArticleService} from "../service/article.service";
import {Article, Book, Game, Lp} from "../model/Articles";
import {BehaviorSubject} from "rxjs";


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
  export class DisplayInventoryComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'type', 'price'];
  dataSource: MatTableDataSource<Article>;
  allArticles: Array<Article>;
  displayedColumnsMap : Map<string, string[]> = new Map<string, string[]>();

  @Input()
  articleType: BehaviorSubject<string>;
  // articleType: BehaviorSubject<string> = new BehaviorSubject<string>('all');

  @Input()
  articleList: Array<Article|Book|Game|Lp>;

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;

  constructor(private articleService: ArticleService, private changeDetectorRefs: ChangeDetectorRef) {
    this.provideDisplayedColumns();

    // Assign the data to the data source for the table to render
    this.dataSource = new MatTableDataSource(this.articleService.currentArticles());
    this.articleService.displayedArticlesO.subscribe(articleList => {
      console.log(articleList)
      this.dataSource.data=articleList;
      // this.changeDetectorRefs.detectChanges();
    });
  }

    private provideDisplayedColumns() {
      this.displayedColumnsMap.set('all', ['name', 'type', 'price']);
      this.displayedColumnsMap.set('book', [ 'type', 'price']);
      this.displayedColumnsMap.set('game', ['name',  'price']);
      this.displayedColumnsMap.set('lp', ['name', 'type']);
    }

    ngOnInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
    this.dataSource.connect();
    // this.articleService.allArticles().subscribe(value => {
    //  console.log(value)
    // });

    this.articleService.findAll()
    // this.articleService.allArticles2().subscribe(value => {
    //   console.log(value)
    //   this.allArticles = value;
    // })

    this.articleType.subscribe(type => {
      console.log("Article Type Selection Through!!!",type);
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


