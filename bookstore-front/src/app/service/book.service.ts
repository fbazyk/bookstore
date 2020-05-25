import {Injectable, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Article, Book} from "../model/Articles";
import {environment} from "../../environments/environment";
import {map, tap} from "rxjs/operators";
import {BehaviorSubject} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class BookService implements OnInit{

  constructor(private http: HttpClient) {

  }

  private firstBook: Book = new Book("book", 0, "OCA", 1000, "333", "Susan", "", 9000);

  public allBooksBs: BehaviorSubject<Array<Book>> = new BehaviorSubject<Array<Book>>([this.firstBook]);


  findAll() {
    console.log("Find All Books")
    console.log(this.allBooksBs.getValue())
    return this.http.get<Array<Book>>(`${environment.apiUrl}/inventory/articles`).pipe(
      tap(x => console.log("Piped from response", x, "Type of X = ", typeof x)),)
      .subscribe(result => {
        this.allBooksBs.next(result);
        console.log("In Subscription:", result)
      })
  }


  ngOnInit(): void {
  }


}
