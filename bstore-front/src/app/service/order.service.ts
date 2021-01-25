import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {BehaviorSubject} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  public currentOrder = new BehaviorSubject(null);
  constructor(private http: HttpClient) { }

  getOrderedArticles(id: number){
    this.http.get(`${environment.apiUrl}/orders/${id}`).subscribe(value => {
      console.log(value);
      this.currentOrder.next(value);
    })
  }
}
