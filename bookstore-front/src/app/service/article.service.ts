import {Injectable, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Article, Book, Game, Lp, typeMapping} from "../model/Articles";
import {User} from "../model/User";
import {environment} from "../../environments/environment";
import {map, tap} from "rxjs/operators";
import {BehaviorSubject, Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class ArticleService implements OnInit {

  private allArticlesBS: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article|Book|Game|Lp>>([{
    type: 'book',
    id: 1,
    title: '',
    price: 0,
    supplierId: '111',
    author: '',
    isbn: '123123123',
    pages: 100
  }]);
  public allArticles1: Observable<Array<Article>> = this.allArticlesBS.asObservable();

  public selectedCategory: BehaviorSubject<string> = new BehaviorSubject<string>("all");

  constructor(private http: HttpClient) {
    this.findAll();
  }

  currentArticles(){
    return this.allArticlesBS.getValue();
  }

  findAll() {
    return this.http.get<Array<Article>>(`${environment.apiUrl}/inventory/articles`).pipe(
      tap(x => console.log("Piped from response", x, "Type of X = ", typeof x)),
      map(this.classifyArticles),
      tap(x => console.log("Piped from cast", x, "Type of X = ", typeof x)),)
      .subscribe(result => {
        this.allArticlesBS.next(result);
        console.log("In Subscription:", result)
      })
  }


  /**
   * Apply types to incoming JSON based on the "type" field.
   * */
  classifyArticles(array) {
    let subclassesArray: Array<Article> = new Array<Article>();
    array.forEach((article: any) => {
      let target: any = new typeMapping[article.type];
      for (const key in article) {
        target[key] = article[key];
      }
      subclassesArray.push(target);
    });
    return subclassesArray;
  }

  ngOnInit(): void {
  }

}
