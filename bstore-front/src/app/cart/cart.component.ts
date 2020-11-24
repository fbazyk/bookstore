import {Component, OnInit, ViewChild} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";
import {OrderDTO, OrderItem} from "../model/OrderDTO";
import {CartService} from "../service/cart.service";
import {MatTableDataSource} from "@angular/material/table";
import {Article} from "../model/Articles";
import {MatPaginator} from "@angular/material/paginator";
import {MatSort} from "@angular/material/sort";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;
  //May be null?
  openOrder: OrderDTO;
  dataSource: MatTableDataSource<OrderItem>;
  displayedColumns: string[] = ["articleId", "articleType", "price", "quantity"]
  displayQuantity: boolean = true;

  constructor(private http: HttpClient,
              private router: Router,
              private cartService: CartService) {
  }

  ngOnInit(): void {
    console.log("Initialize Cart")
    this.getCart()
    this.cartService.openOrder.subscribe(value => {
      if(!!value){
        this.openOrder = value;
        this.openOrder.orderItems.forEach(orderItem => {
          orderItem.editQuantity = false;
          this.dataSource.data = this.openOrder?.orderItems;
        })
      }
    })
    this.dataSource = new MatTableDataSource<OrderItem>()
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
    this.dataSource.paginator.pageSize = 9;
    this.dataSource.connect();
  }

  private getCart() {
    this.cartService.getCart();
  }
  //TODO Display OrderTotal, CartDate
  //TODO Display Table with OrderItems and buttons to adjust quantity and delete item
  //TODO DELETE button
  //TODO Adjust Quantity button (in a separate component)
  //TODO from ArticleService get the information about products:
  //TODO Title
  updateQuantity($event: any) {
    console.log($event)
  }

  editQuantity(orderItem: OrderItem) {
    orderItem.editQuantity = true;
  }
}
