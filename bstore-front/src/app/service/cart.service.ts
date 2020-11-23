import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";
import {OrderDTO} from "../model/OrderDTO";
import {BehaviorSubject, Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class CartService {

  private openOrderBS: BehaviorSubject<OrderDTO> = new BehaviorSubject<OrderDTO>(null);
  public openOrder: Observable<OrderDTO> = this.openOrderBS.asObservable();

  constructor(private http: HttpClient,
              private router: Router,) {
  }

  getCart() {
    this.http.get(`${environment.apiUrl}/cart`, {observe: "body", responseType: "json"})
      .subscribe((value: OrderDTO) => {
        console.log("OpenOrder:")
        console.log(value)
        this.openOrderBS.next(value);
      })
  }

}
