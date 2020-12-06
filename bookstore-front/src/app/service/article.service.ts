import {Injectable, NgZone, OnInit} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {Article, Book, Game, Lp, articleTypeMapping, Item} from "../model/Articles";
import {User} from "../model/User";
import {environment} from "../../environments/environment";
import {map, tap, withLatestFrom} from "rxjs/operators";
import {combineLatest} from "rxjs/index";
import {BehaviorSubject, Observable} from "rxjs";
import {errorObject} from "rxjs/internal-compatibility";
import {MatSnackBar} from "@angular/material/snack-bar";
import {Router} from "@angular/router";

@Injectable({
  providedIn: 'root'
})
export class ArticleService implements OnInit {
  provideState: string = "all";
  isLoading: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);

  private allArticles: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article | Book | Game | Lp>>([{
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
              public router: Router,
              public snackBar: MatSnackBar,
              private zone: NgZone) {
    this.subscribeTo()
  }

  currentArticles() {
    return this.allArticles.getValue();
  }

  subscribeToCategoryChanges() {
    this.selectedCategory.subscribe(value => {
      this.displayedArticles.next(this.allArticles.getValue().filter(value1 => {
        return value1.type == value || value == 'all'
      }));
    })
  }

  subscribeToAllArticlesUpdate() {
    this.allArticles.subscribe(value => {
      this.displayedArticles.next(value)
    })
  }

  subscribeTo() {
    const list = this.allArticles;
    const type = this.selectedCategory;

    const result = combineLatest([list, type]);
    result.subscribe(([articleList, categoryType]) => {
      this.displayedArticles.next(articleList.filter(article => {
        return !!article && article.type == categoryType || categoryType == 'all'
      }))
    })
  }



  // findByCategory(){
  //   return this.http.post(`${environment.apiUrl}/`)
  // }

  findAll() {
    return this.http.get<Array<Article>>(`${environment.apiUrl}/articles`).pipe(
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
   * On success
   * */
  delete(type: string, id: number) {
    //show bar on start
    let actionSnackBar = this.snackBar.open(`Deleting ${type + ' ' + id} `)
    //send request
    this.isLoading.next(true);
    this.http.delete(`${environment.apiUrl}/article/${type}/${id}`, {observe: 'body', responseType: 'text'}).subscribe(response => {
      console.log(response);
      //show a new bar with success
        let successSnackBar = this.snackBar.open(`${response}`,"", {duration: 2500})

        //find where it was in currently displayed articles
        let index: number = this.allArticles.getValue().findIndex(value => {
          return value.type == type && value.id == id;
        });
        this.allArticles.next(this.allArticles.getValue().splice(index, 1));
        this.isLoading.next(false);
    }, (error: HttpErrorResponse) => {
      console.log(error)
      let failureSnackBar = this.snackBar.open(`Unable to delete! ${error}`, 'Dismiss', {duration: 2500})
    })


  }

  /**
   * SubmitArticle sends Article to back-end for storage in DB.
   * Called by the EditArticle Component, providing the article data from the form
   * if Id = 0, it's a new article, and PUT method is used
   * if Id > 0, it's an existing article, and post method is used.
   * The success triggers reload of All Articles
   *
   * //or should it receive the new article and put into AllArticles - the stuff gets more tightly coupled... w/e, for later then.
   * For now see above: reload all articles.
   * */
  submitArticle(submittedArticle: Article) {
    let actionSnackBar = this.snackBar.open(`Submitting ${submittedArticle.type + ' ' + submittedArticle.id + submittedArticle.title} `);
    this.isLoading.next(true);
    // submittedArticle.id == 0 only if it's a new article
    if (submittedArticle.id > 0) {
      this.http.post(`${environment.apiUrl}/article/${submittedArticle.type}/${submittedArticle.id}`, submittedArticle, {responseType: "text"}).subscribe(response => {
        console.log(response);
        let successSnackBar = this.snackBar.open(`Article ${submittedArticle.type + ' ' + submittedArticle.id} was updated.`, null, {duration: 2500})
        this.isLoading.next(false);
        this.router.navigateByUrl('/inventory')
      }, error => {
        console.log(error)
      });
    } else {
      this.http.put(`${environment.apiUrl}/article/${submittedArticle.type}`, submittedArticle, {responseType: "text"}).subscribe(response => {
        console.log(response);
        let successSnackBar = this.snackBar.open(`Article ${submittedArticle.type + ' ' + submittedArticle.title} was created.`, null, {duration: 2500})
        this.isLoading.next(false);
        this.router.navigateByUrl('/inventory')
      },error => {
        let failureSnackBar = this.snackBar.open(`Not Able To Create! ${submittedArticle.type + ' ' + submittedArticle.title}`, null, {duration: 2500})
      })
    }
  }

  /**
   * Accepts list of foundArticles coming from Search request.
   * Feeds AllArticles pipeline.
   * Resets the category select to All.
   * */
  foundArticles(foundArticles: Array<Article>) {
    console.log("ArticleService accepts foundArticles: ", foundArticles);
    this.allArticles.next(foundArticles);
    this.selectedCategory.next('all');
  }
}
