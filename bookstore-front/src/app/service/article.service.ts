import {Injectable, NgZone, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Article, Book, Game, Lp, articleTypeMapping, Item} from "../model/Articles";
import {User} from "../model/User";
import {environment} from "../../environments/environment";
import { map, tap, withLatestFrom} from "rxjs/operators";
import { combineLatest } from "rxjs/index";
import {BehaviorSubject, Observable} from "rxjs";
import {errorObject} from "rxjs/internal-compatibility";
import {MatSnackBar} from "@angular/material/snack-bar";

@Injectable({
  providedIn: 'root'
})
export class ArticleService implements OnInit {
  provideState: string = "all";
  isLoading: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);

  private allArticles: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article|Book|Game|Lp>>([{
    type: 'book',
    id: 1,
    title: '',
    price: 0,
    supplierId: '111',
    author: '',
    isbn: '123123123',
    pages: 100
  }]);

  private displayedArticles: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article>>(this.allArticles.getValue());
  public allArticlesO: Observable<Array<Article>> = this.allArticles.asObservable();
  public displayedArticlesO: Observable<Array<Article>> = this.displayedArticles.asObservable();

  public selectedCategory: BehaviorSubject<string> = new BehaviorSubject<string>(this.provideState);
  // public lastCategory: BehaviorSubject<string> = new BehaviorSubject<string>(this.provideState);


  constructor(private http: HttpClient,
              public snackBar: MatSnackBar,
              private zone: NgZone) {
    // this.subscribeToCategoryChanges();
    // this.subscribeToAllArticlesUpdate()
    this.subscribeTo()
    // this.findAll();
  }

  currentArticles(){
    return this.allArticles.getValue();
  }

  subscribeToCategoryChanges(){
    this.selectedCategory.subscribe(value => {
        this.displayedArticles.next(this.allArticles.getValue().filter(value1 => {
          return value1.type == value || value == 'all'
        }));
    })
  }

  subscribeToAllArticlesUpdate(){
    this.allArticles.subscribe(value => {
      this.displayedArticles.next(value)
    })
  }

  subscribeTo(){
    const list = this.allArticles;
    const type = this.selectedCategory;

    const result = combineLatest([list, type]);
    result.subscribe(([articleList, categoryType]) => {
      this.displayedArticles.next( articleList.filter(article => {
        return article.type == categoryType || categoryType == 'all'
      }))
    })
  }

  // findByCategory(){
  //   return this.http.post(`${environment.apiUrl}/`)
  // }

  findAll() {
    return this.http.get<Array<Article>>(`${environment.apiUrl}/inventory/articles`).pipe(
      tap(x => console.log("Piped from response", x, "Type of X = ", typeof x)),
      map(this.typeArticles),
      tap(x => console.log("Piped from cast", x, "Type of X = ", typeof x)),)
      .subscribe(result => {
        this.allArticles.next(result);
        console.log("In Subscription:", result)
      })
  }


  /**
   * Apply types to incoming JSON based on the "type" field.
   * */
  typeArticles(array) {
    let subclassesArray: Array<Article> = new Array<Article>();
    array.forEach((article: any) => {
      let target: any = new articleTypeMapping[article.type];
      for (const key in article) {
        target[key] = article[key];
      }
      subclassesArray.push(target);
    });
    return subclassesArray;
  }

  ngOnInit(): void {
  }

  getArticle(type: string, id: number): Article {
    console.log('getting article ', type, id)
    let articleFound = this.allArticles.getValue().filter(article => {
      return article.type == type && article.id == id;
    })[0]
    if (!!articleFound) {
      return articleFound;
    } else {
      throw errorObject;
    }
  }

/**
 * Delete an article by String and Id
 * */
  delete(type: string, id: number) {
  //show bar on start
  let actionSnackBar = this.snackBar.open(`Deleting ${type + ' ' + id} `)
  //send request
  console.log (this.isLoading)
  console.log (this.isLoading.getValue())
  this.isLoading.next(true);
  this.http.delete(`${environment.apiUrl}/article/${type}/${id}`).subscribe(response => {
    console.log(response);
    if(!!response){
      //show a new bar with success
      let successSnackBar = this.snackBar.open(`Article ${type + ' ' + id} was deleted.`, 'Dismiss', {duration: 2500})

      let index: number = this.allArticles.getValue().findIndex(value => {
        return value.type == type && value.id == id;
      });
      this.allArticles.next(this.allArticles.getValue().splice(index, 1));
      this.isLoading.next(false);
    }
  })


  }
}
