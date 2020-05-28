import { Injectable } from '@angular/core';
import {ArticleService} from "./article.service";
import {BehaviorSubject} from "rxjs";
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Article} from "../model/Articles";
import {provideEmptySearchState, SearchState} from "../model/SearchState";


@Injectable({
  providedIn: 'root'
})
export class SearchService {
  searchState: BehaviorSubject<SearchState> = new BehaviorSubject<SearchState>(provideEmptySearchState());

  constructor(private articleService: ArticleService, private http: HttpClient) {
    this.searchState.subscribe(value => {
      console.log(value)
    })
    console.log("SEARCH SERVICE INITIALIZED!!!")

  }

  /**
   * Sends search request to back-end containing
   * @param searchState
   * Then feeds foundArticles to allArticles display pipeline
   * what other side effects should it cause??
   * */
  searchArticles(searchState: SearchState){
    console.log("Searching for: ", searchState)
    this.http.post<Array<Article>>(`${environment.apiUrl}/article/search`, searchState).subscribe(foundArticles => {
      console.log("Response from Search", foundArticles);
      this.articleService.foundArticles(foundArticles)
    });
  }
}
