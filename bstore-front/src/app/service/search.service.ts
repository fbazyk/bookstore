import {Injectable} from '@angular/core';
import {ArticleService} from "./article.service";
import {BehaviorSubject} from "rxjs";
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Article} from "../model/Articles";
import {provideEmptySearchState, SearchState} from "../model/SearchState";
import {MatSnackBar} from "@angular/material/snack-bar";


@Injectable({
  providedIn: 'root'
})
export class SearchService {
  searchState: BehaviorSubject<SearchState> = new BehaviorSubject<SearchState>(provideEmptySearchState());

  constructor(private articleService: ArticleService,
              private http: HttpClient,
              public snackBar: MatSnackBar) {
    // this.searchState.subscribe(value => {
    //   console.log(value)
    // })
    console.log("SEARCH SERVICE INITIALIZED!!!")

  }

  search(){

  }

  /**
   * Sends search request to back-end containing
   * @param searchState
   * Then feeds foundArticles to allArticles display pipeline
   * what other side effects should it cause??
   * */
  searchArticles(searchState: SearchState) {
    console.log("Searching for: ", searchState)

    let fieldsWithData = searchState.fields;
    fieldsWithData.forEach((value, key) => {
      if (!!value) {
      } else {
        fieldsWithData.delete(key);
      }
    });
    const convMap = {};
    fieldsWithData.forEach((val: string, key: string) => {
      convMap[key] = val;
    });

    if (fieldsWithData.size > 1) {
      this.http.post<Array<Article>>(`${environment.apiUrl}/article/search`, convMap).subscribe(foundArticles => {
        console.log("Response from Search", foundArticles);
        if(!!foundArticles){
          this.articleService.foundArticles(foundArticles)
        } else {
          let successSnackBar = this.snackBar.open(`No Results from Search`,"", {duration: 2500})
        }
      },error => {
        console.log(error)
      });
    }
  }
}
