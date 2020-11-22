import {Component, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {

  constructor(private http: HttpClient,
              private router: Router) {
  }

  ngOnInit(): void {
    this.getCart()
  }

  private getCart() {
    this.http.get(`${environment.apiUrl}/cart`)
      .subscribe(value => {
        console.log(value)
      })
  }
  //TODO Display OrderTotal, CartDate
  //TODO Display Table with OrderItems and buttons to adjust quantity and delete item
  //
}
