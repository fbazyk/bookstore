import {Injectable, NgZone, OnInit} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {Article, Book, Game, Lp, articleTypeMapping, Item} from "../model/Articles";
import {User} from "../model/User";
import {environment} from "../../environments/environment";
import {debounceTime, map, tap, withLatestFrom} from "rxjs/operators";
import {combineLatest} from "rxjs/index";
import {BehaviorSubject, Observable} from "rxjs";
import {errorObject} from "rxjs/internal-compatibility";
import {MatSnackBar} from "@angular/material/snack-bar";
import {Router} from "@angular/router";
import {ArticlesPage, PageRequest} from "../model/ArticlesPage";
import {provideEmptySearchState, SearchState} from "../model/SearchState";
import {SearchDTO} from "../model/SearchDTO";

@Injectable({
  providedIn: 'root'
})
export class ArticleService implements OnInit {
  providedCategoryState: string = "all";
  isLoading: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  filterValue: BehaviorSubject<String> = new BehaviorSubject<String>("")
  searchState: BehaviorSubject<SearchDTO> = new BehaviorSubject<SearchDTO>({
    articleId: null,
    articleType: "all",
    maxPrice: null,
    minPrice: null,
    searchTitle: "",
    sortBy: "",
    sortOrder: ""
  });
  //
  // private allArticles: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article | Book | Game | Lp>>([{
  //   type: 'book',
  //   id: 1,
  //   title: '',
  //   price: 0,
  //   supplierId: '111',
  //   author: '',
  //   isbn: '123123123',
  //   pages: 100
  // }]);
  public pagedArticles: BehaviorSubject<ArticlesPage> = new BehaviorSubject<ArticlesPage>(null);

  // private displayedArticles: BehaviorSubject<Array<Article>> = new BehaviorSubject<Array<Article>>(this.allArticles.getValue());
  // public allArticlesO: Observable<Array<Article>> = this.allArticles.asObservable();
  // public displayedArticlesO: Observable<Array<Article>> = this.displayedArticles.asObservable();

  public selectedCategory: BehaviorSubject<string> = new BehaviorSubject<string>(this.providedCategoryState);

  // public lastCategory: BehaviorSubject<string> = new BehaviorSubject<string>(this.provideState);
  pageRequest: BehaviorSubject<PageRequest> =
    new BehaviorSubject<PageRequest>({pageIndex: 1, pageSize: 5});


  constructor(private http: HttpClient,
              public router: Router,
              public snackBar: MatSnackBar,
              private zone: NgZone) {
    // this.combineSubscriptions()
    this.combineCategoryPaging()
    // this.combineFiltering()
  }

  combineFiltering(){
    const filter = this.filterValue.pipe(debounceTime(750));
    const type = this.selectedCategory;
    const pageRequest = this.pageRequest;
    //TODO combine filter and category, provide page size
    const result  = combineLatest([filter, type, pageRequest]);

    result.subscribe(([filter, category, pageRequest])=>{
      console.log(filter)
      this.findCategoryFilteredPaged(category, filter, pageRequest.pageSize, 1);
    })
  }

  combineSubscriptions() {
    const type = this.selectedCategory;
    const pageRequest = this.pageRequest;
    const result = combineLatest([pageRequest, type]);
    result.subscribe(([pageRequest, categoryType]) => {
      this.findPagedCategory(pageRequest.pageIndex, pageRequest.pageSize, type.value)
    })
  }

  combineCategoryPaging() {
    const result = this.pageRequest.pipe(withLatestFrom(this.selectedCategory, this.filterValue, this.searchState))

    // const result2 = combineLatest([pageRequest, type]);
    result.subscribe(([pageRequest, category, filter, searchState]) => {
      // this.findPagedCategory(pageRequest.pageIndex, pageRequest.pageSize, category)
      // this.findCategoryFilteredPaged(category, filter, pageRequest.pageSize, pageRequest.pageIndex)
      this.search(pageRequest.pageIndex, pageRequest.pageSize, category, filter, searchState);
    })
    this.selectedCategory.subscribe(category => {
      if(!!category){
        this.search(1, this.pageRequest.value.pageSize, category, this.filterValue.value,  this.searchState.value);
      }
    })
    this.filterValue.pipe(debounceTime(750)).subscribe(filter => {
      if(!!filter){
        this.search(1, this.pageRequest.value.pageSize, this.selectedCategory.value, filter,  this.searchState.value)
      }
      // this.findCategoryFilteredPaged(this.selectedCategory.value, filter, this.pageRequest.value.pageSize, 1)
    })
    this.searchState.subscribe(searchDTO => {
      console.log("New SearchDTO is {}", searchDTO);
      if(!!searchDTO){
        this.search(1, this.pageRequest.value.pageSize, this.selectedCategory.value, this.filterValue.value, searchDTO)
      }
    })

  }

  search(page, psize, category, filter, searchDTO){
    // let page = this.pageRequest.value.pageIndex;
    // let psize = this.pageRequest.value.pageSize;
    // let category = this.selectedCategory.value;
    // let filter = this.filterValue.value;
    this.http.post(`${environment.apiUrl}/article/search?page=${page}&psize=${psize}&category=${category}&filter=${filter}`, this.searchState.value).subscribe((value:ArticlesPage) => {
      console.log("Response: {}", value);
      this.pagedArticles.next(value);
    })
  }

  findPagedCategory(page, psize, selectedCategory) {
    return this.http
      .get<ArticlesPage>(`${environment.apiUrl}/articlescatpaged?page=${page}&psize=${psize}&category=${selectedCategory}`)
      .subscribe(value => {
        console.log(value)
        this.pagedArticles.next(value);
      })
  }

  public findCategoryFilteredPaged(category, filter, psize, page) {
    console.log("FIND CATEGORY FILTERED PAGED")
    console.log(category);
    console.log(filter);
    console.log(psize);
    console.log(page);
    return this.http
      .get<ArticlesPage>(`${environment.apiUrl}/articlescatfilteredpaged?page=${page}&psize=${psize}&category=${category}&filter=${filter}`)
      .subscribe(value => {
        console.log(value)
        this.pagedArticles.next(value);
      })
  }

  findPaged(page, psize) {
    return this.http
      .get<ArticlesPage>(`${environment.apiUrl}/articlespaged?page=${page}&psize=${psize}`)
      .subscribe(value => {
        this.pagedArticles.next(value);
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
    let articleFound = this.pagedArticles.getValue().articles.filter(article => {
      return article.type == type.toLowerCase() && article.id == id;
    })[0]
    if (!!articleFound) {
      return articleFound;
    } else {
      throw errorObject;
    }
  }

  getArticleFromServer(type: string, id: number){
    return this.http.get(`${environment.apiUrl}/article/${type}/${id}`, {observe:"body"});
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
    this.http.delete(`${environment.apiUrl}/article/${type}/${id}`, {
      observe: 'body',
      responseType: 'text'
    }).subscribe(response => {
      console.log(response);
      //show a new bar with success
      let successSnackBar = this.snackBar.open(`${response}`, "", {duration: 2500})
      this.selectedCategory.next(type);
      //find where it was in currently displayed articles
      // let index: number = this.allArticles.getValue().findIndex(value => {
      //   return value.type == type && value.id == id;
      // });
      // this.allArticles.next(this.allArticles.getValue().splice(index, 1));
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
    let actionSnackBar = this.snackBar.open(
      `Submitting ${submittedArticle.type} ${submittedArticle.id} ${submittedArticle.title}`);
    this.isLoading.next(true);
    // submittedArticle.id == 0 only if it's a new article
    if (submittedArticle.id > 0) {
      this.http.post(`${environment.apiUrl}/article/${submittedArticle.type}/${submittedArticle.id}`, submittedArticle, {responseType: "text"}).subscribe(response => {
        let successSnackBar = this.snackBar.open(`Article ${submittedArticle.type} ${submittedArticle.id} was updated.`, null, {duration: 2500})
        this.isLoading.next(false);
        this.findPagedCategory(this.pageRequest.value.pageIndex,
          this.pageRequest.value.pageSize, this.selectedCategory.value)
        this.filterValue.next("");
        this.router.navigateByUrl('/inventory')
      }, (error: HttpErrorResponse) => {
        if (error.status == 417) {
          this.snackBar.open("ISBN did not pass Back-End validation", "", {duration: 5000})
        }
        if (error.status == 422) {
          this.snackBar.open("Book with the same ISBN already exists", "", {duration: 5000})
        }

        console.log(error)
      });
    } else {
      this.http.put(`${environment.apiUrl}/article/${submittedArticle.type}`, submittedArticle, {responseType: "text"}).subscribe(response => {
        console.log(response);
        let successSnackBar = this.snackBar.open(`Article ${submittedArticle.type + ' ' + submittedArticle.title} was created.`, null, {duration: 2500})
        this.isLoading.next(false);
        this.router.navigateByUrl('/inventory')
      }, (error: HttpErrorResponse) => {
        if (error.status == 417) {
          this.snackBar.open("ISBN did not pass Back-End validation", "", {duration: 5000})
        }
        if (error.status == 422) {
          this.snackBar.open("Book with the same ISBN already exists", "", {duration: 5000})
        }
        // let failureSnackBar = this.snackBar.open(`Not Able To Create! ${submittedArticle.type + ' ' + submittedArticle.title}`, null, {duration: 2500})
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
    // this.allArticles.next(foundArticles);
    // this.selectedCategory.next('all');
  }

}
