import { Component, OnInit, OnDestroy } from '@angular/core';
import {OrderService} from "../service/order.service";
import {Subscription} from "rxjs";
import {OrderDTO, OrdersDTO} from "../model/OrderDTO";
import {MatTableDataSource} from "@angular/material/table";
import {MatDialog, MatDialogConfig} from "@angular/material/dialog";
import {DisplayOrderArticlesComponent} from "../display-order-articles/display-order-articles.component";
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";

@Component({
  selector: 'app-admin-orders',
  templateUrl: './admin-orders.component.html',
  styleUrls: ['./admin-orders.component.css']
})
export class AdminOrdersComponent implements OnInit {


  private subscriptions: Subscription[] = [];
  displayedColumns: string[] = ['id', 'date', 'total', 'packinglist'];
  dataSource: MatTableDataSource<OrderDTO> = new MatTableDataSource<OrderDTO>();
  //TODO Obtain orders with orderDate
  //TODO mark orders without shippedDate
  //TODO
  constructor(
    private orderService: OrderService,
    public matDialog: MatDialog,
    private http: HttpClient,
  ) { }

  ngOnInit(): void {
    this.orderService.getNewOrders()
    let newOrdersSub = this.orderService.newOrders$.subscribe(value => {
      if(!!value){
        let orders = Object.assign(new OrdersDTO(), value)
        this.dataSource.data = orders.orderList;
      }
    })
    this.subscriptions.push(newOrdersSub);
  }

  ngOnDestroy(): void{
    for(let subscription of this.subscriptions){
      subscription.unsubscribe();
    }
  }

  getPackingList($event: MouseEvent, order: any) {
    $event.stopPropagation()
    console.log($event)
    console.log(order)
    this.http.get(`${environment.apiUrl}/orders/plist/${order.orderId}`).subscribe(value => {
      console.log(value);
    })

  }

  showOrder(event: MouseEvent, order: any) {
    //TODO show order
    console.log(event)
    console.log(order)
    const dialogConfig = new MatDialogConfig();
    // The user can't close the dialog by clicking outside its body

    dialogConfig.disableClose = false;
    dialogConfig.id = "display-order-articles-component";
    dialogConfig.height = "auto";
    dialogConfig.width = "80vw";
    dialogConfig.data = {
      order: order
    };
    // https://material.angular.io/components/dialog/overview
    const modalDialog = this.matDialog.open(DisplayOrderArticlesComponent, dialogConfig);
  }
}
