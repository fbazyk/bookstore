import {Injectable, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Article, Book, Game, Lp, articleTypeMapping} from "../model/Articles";
import {User} from "../model/User";
import {environment} from "../../environments/environment";
import {map, tap} from "rxjs/operators";
import {BehaviorSubject, Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class ArticleService implements OnInit {
  provideState: string = "all";


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

  constructor(private http: HttpClient) {
    this.findAll();
    this.subscribeToCategoryChanges();

  }

  currentArticles(){
    return this.allArticles.getValue();
  }

  //TODO
  subscribeToCategoryChanges(){
    this.selectedCategory.subscribe(value => {
      //1) show new value
      console.log("SelectedCategory: ", value)
      this.displayedArticles.next(this.allArticles.getValue().filter(value1 => {

        console.log(value1.type)
        console.log(value)
        return value1.type == value || value == 'all'
      }));
      //2) tell display component to filter the full data ==>> bullshit
      //tryagain: get new data from the service
      //3) display new data.
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

}
