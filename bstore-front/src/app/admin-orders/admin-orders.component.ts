import { Component, OnInit, OnDestroy } from '@angular/core';
import {OrderService} from "../service/order.service";
import {Subscription} from "rxjs";

@Component({
  selector: 'app-admin-orders',
  templateUrl: './admin-orders.component.html',
  styleUrls: ['./admin-orders.component.css']
})
export class AdminOrdersComponent implements OnInit {


  private subscriptions: Subscription[];
  //TODO Obtain orders with orderDate
  //TODO mark orders without shippedDate
  //TODO
  constructor(
    private orderService: OrderService
  ) { }

  ngOnInit(): void {
    this.orderService.getNewOrders()
    let newOrdersSub = this.orderService.newOrders$.subscribe(value => {
      console.log(value);
    this.subscriptions.push(newOrdersSub);
    })
  }

  ngOnDestroy(): void{
    for(let subscription of this.subscriptions){
      subscription.unsubscribe();
    }
  }
}
