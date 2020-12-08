import {Component, HostListener, OnInit, ViewChild} from '@angular/core';
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";
import {OrderDTO, OrderItem} from "../model/OrderDTO";
import {CartService} from "../service/cart.service";
import {MatTable, MatTableDataSource} from "@angular/material/table";
import {Article} from "../model/Articles";
import {MatPaginator} from "@angular/material/paginator";
import {MatSort} from "@angular/material/sort";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ArticleService} from "../service/article.service";
import * as moment from 'moment';
import {Location} from "@angular/common";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;
  @ViewChild(MatTable, {static: false}) table: MatTable<any>
  //May be null?
  openOrder: OrderDTO;
  dataSource: MatTableDataSource<OrderItem>;
  displayedColumns: string[] = ["articleId", "articleType", "title", "price", "quantity", "itemtotal"]
  displayQuantity: boolean = true;
  cartDate: Date;
  cartDateFormatted: string;

  booksQuantity: number = 0;
  booksTotal: number = 0;

  gamesQuantity: number = 0;
  gamesTotal: number = 0;

  lpsQuantity: number = 0;
  lpsTotal: number = 0;

  constructor(private http: HttpClient,
              private router: Router,
              private snackBar: MatSnackBar,
              private cartService: CartService,
              private articleService: ArticleService,
              private location: Location) {
  }

  ngOnInit(): void {
    console.log("Initialize Cart")
    this.dataSource = new MatTableDataSource<OrderItem>()
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
    this.dataSource.paginator.pageSize = 9;
    this.dataSource.connect();
    this.getCart()
    this.cartService.openOrder.subscribe(value => {
      if (!!value) {
        this.openOrder = value;
        this.cartDate = new Date(this.openOrder.cartDate)
        this.cartDateFormatted = moment(this.cartDate).format('DD/MM/YYYY HH:MM');
        if (this.openOrder.orderItems.length > 0) {
          this.openOrder.orderItems.forEach(orderItem => {
            orderItem.title = this.articleService.getArticle(orderItem.articleType, orderItem.articleId).title;
            orderItem.editQuantity = false;

            if (orderItem.articleType == 'BOOK') {
              this.booksQuantity = this.booksQuantity + orderItem.quantity;
              this.booksTotal = this.booksTotal + (orderItem.quantity * orderItem.price);
            }
            if (orderItem.articleType == 'GAME') {
              this.gamesQuantity = this.gamesQuantity + orderItem.quantity;
              this.gamesTotal = this.gamesTotal + (orderItem.quantity * orderItem.price);
            }
            if (orderItem.articleType == 'LP') {
              this.lpsQuantity = this.lpsQuantity + orderItem.quantity;
              this.lpsTotal = this.lpsTotal + (orderItem.quantity * orderItem.price);
            }


            this.dataSource.data = this.openOrder?.orderItems;
          })
        } else {
          this.dataSource.data = []
          // this.table.renderRows();

        }
        this.updateDisplayedQuantity();
      }
    })

  }

  private getCart() {
    this.cartService.getCart();
  }

  //TODO Beautify OrderTotal,
  // TODO Format CartDate
  //TODO DELETE button
  //TODO Title
  updateQuantity(orderItem: OrderItem) {
    if (orderItem.quantity >= 1) {
      this.cartService.updateQuantity(orderItem);
    } else {
      orderItem.quantity = 1
      this.cartService.updateQuantity(orderItem);
      let actionSnackBar = this.snackBar.open(`Quantity should be positive`, "", {duration: 2500})
    }
    this.updateDisplayedQuantity();

  }


  editQuantity(orderItem: OrderItem) {
    console.log("Edit Quantity")

    this.openOrder.orderItems.forEach(value => {
      value.editQuantity = false;
    })
    orderItem.editQuantity = true;
  }

  updateDisplayedQuantity() {
    this.booksTotal = 0;
    this.booksQuantity = 0;
    this.gamesTotal = 0;
    this.gamesQuantity = 0;
    this.lpsTotal = 0;
    this.lpsQuantity = 0;
    this.openOrder.orderItems.forEach(orderItem => {
      if (orderItem.articleType == 'BOOK') {
        this.booksQuantity = this.booksQuantity + orderItem.quantity;
        this.booksTotal = this.booksTotal + (orderItem.quantity * orderItem.price);
      }
      if (orderItem.articleType == 'GAME') {
        this.gamesQuantity = this.gamesQuantity + orderItem.quantity;
        this.gamesTotal = this.gamesTotal + (orderItem.quantity * orderItem.price);
      }
      if (orderItem.articleType == 'LP') {
        this.lpsQuantity = this.lpsQuantity + orderItem.quantity;
        this.lpsTotal = this.lpsTotal + (orderItem.quantity * orderItem.price);
      }
    })

  }


  cartDate2() {
    if (!!this.openOrder) {
      let asdf = Date.parse(this.openOrder.cartDate)
      console.log(asdf)
    }
    return true;
  }

  placeOrder() {
    this.http.post(`${environment.apiUrl}/order`, {}).subscribe(value => {
      console.log(value);
      this.cartService.getCart();
      // this.dataSource.data = []
      this.updateDisplayedQuantity();
    }, (error: HttpErrorResponse) => {
      if (error.status == 417) {
        console.log(error);
        this.cartService.getCart();
        this.updateDisplayedQuantity();
        let actionSnackBar = this.snackBar.open(`Some items were not available at supplier and were removed`, "", {duration: 5000})
      }
    })
  }

  private updateQuantities() {
    this.booksTotal = 0;
    this.booksQuantity = 0;
    this.gamesTotal = 0;
    this.gamesQuantity = 0;
    this.lpsTotal = 0;
    this.lpsQuantity = 0;
  }

  emptyCart() {
    this.http.delete(`${environment.apiUrl}/order`).subscribe(value => {
      console.log(value);
      this.getCart()
      this.booksTotal = 0;
      this.booksQuantity = 0;
      this.gamesTotal = 0;
      this.gamesQuantity = 0;
      this.lpsTotal = 0;
      this.lpsQuantity = 0;
    });
  }
}
