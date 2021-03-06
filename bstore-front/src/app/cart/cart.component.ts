import {Component, HostListener, OnDestroy, OnInit, ViewChild} from '@angular/core';
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";
import {OrderDTO, OrderItemDTO} from "../model/OrderDTO";
import {CartService} from "../service/cart.service";
import {MatTable, MatTableDataSource} from "@angular/material/table";
import {Article} from "../model/Articles";
import {MatPaginator, PageEvent} from "@angular/material/paginator";
import {MatSort} from "@angular/material/sort";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ArticleService} from "../service/article.service";
import * as moment from 'moment';
import {Location} from "@angular/common";
import {Subscription} from "rxjs";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit, OnDestroy {

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;
  @ViewChild(MatTable, {static: false}) table: MatTable<any>
  //May be null?
  cart: OrderDTO;
  dataSource: MatTableDataSource<OrderItemDTO>;
  private subscriptionRegistry: Subscription[] = new Array<Subscription>();

  displayedOrderItems: OrderItemDTO[];

  displayedColumns: string[] = ["articleId", "articleType", "title", "price", "quantity", "itemtotal", "delete"]
  displayQuantity: boolean = true;
  cartDate: Date;
  cartDateFormatted: string;

  booksQuantity: number = 0;
  booksTotal: number = 0;

  gamesQuantity: number = 0;
  gamesTotal: number = 0;

  lpsQuantity: number = 0;
  lpsTotal: number = 0;

  totalArticles: number = 0;
  currentPage: number = 1;
  totalPages: number;

  constructor(private http: HttpClient,
              private router: Router,
              private snackBar: MatSnackBar,
              private cartService: CartService,
              private articleService: ArticleService,
              private location: Location) {
  }

  ngOnInit(): void {
    console.log("Initialize Cart")
    this.dataSource = new MatTableDataSource<OrderItemDTO>()
    // this.dataSource.paginator = this.paginator;
    // this.dataSource.sort = this.sort;
    this.paginator.pageSize = 5;
    this.paginator.pageIndex = 0;
    // this.paginator.length = 6

    // this.dataSource.connect();

    let orderSub = this.cartService.cartBS.subscribe(cart => {
      if (!!cart) {
        this.cart = cart;
        this.cartDate = new Date(this.cart.cartDate)
        this.cartDateFormatted = moment(this.cartDate).format('DD/MM/YYYY HH:MM');
          this.dataSource.data = []
        this.paginator.pageIndex = 0;
        this.paginator.length = cart.orderItems.length;
        this.cartService.pageRequest.next({pageIndex: this.paginator.pageIndex+1, pageSize: this.paginator.pageSize })
        this.updateDisplayedQuantity();
      }
    })
    this.cartService.getCart()

    let caSub = this.cartService.cartArticlesBS.subscribe(cartArticles => {
      if (!!this.cart && !!cartArticles) {
        console.log("PAGINATOR PAGEINDEX = ", this.paginator)
        this.paginator.length = this.cartService.cartBS.value.orderItems.length;

      this.cartService.cartBS.value.orderItems.forEach(orderItem => {
        orderItem.article = cartArticles.articles.find(article => {
          return article.type.toUpperCase() == orderItem.articleType && article.id == orderItem.articleId;
        })
      })
      this.displayedOrderItems = this.cart.orderItems.filter(value => {
        return !!value.article
      })
      console.log(this.displayedOrderItems)
      this.dataSource.data = this.displayedOrderItems;
    }
    })

    let paginatorSub = this.paginator.page.subscribe(value => {
      console.log("PAGINATOR CHANGE", value)
      this.cartService.pageRequest.next({pageIndex: value.pageIndex+1, pageSize: this.paginator.pageSize })
    })
    this.subscriptionRegistry.push(caSub);
    this.subscriptionRegistry.push(paginatorSub);
    this.subscriptionRegistry.push(orderSub)

  }

  updateQuantity(orderItem: OrderItemDTO) {
    if (orderItem.quantity >= 1) {
      this.cartService.updateQuantity(orderItem);
    } else {
      orderItem.quantity = 1
      this.cartService.updateQuantity(orderItem);
      let actionSnackBar = this.snackBar.open(`Quantity should be positive`, "", {duration: 2500})
    }
    this.updateDisplayedQuantity();

  }


  editQuantity(orderItem: OrderItemDTO) {
    console.log("Edit Quantity")

    this.cart.orderItems.forEach(value => {
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
    this.cart.orderItems.forEach(orderItem => {
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
    if (!!this.cart) {
      let asdf = Date.parse(this.cart.cartDate)
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
      let actionSnackBar = this.snackBar.open(`Order Placed`, "", {duration: 5000})

    }, (error: HttpErrorResponse) => {
      this.cartService.getCart();
      this.updateDisplayedQuantity();

      if (error.status == 417) {
        console.log(error);
        this.cartService.getCart();
        this.updateDisplayedQuantity();
        let actionSnackBar = this.snackBar.open(`Some items were not available at supplier and were removed`, "", {duration: 5000})
      } else if (error.status == 400){
        let actionSnackBar = this.snackBar.open(`Bad Request`, "", {duration: 5000})
      } else if(error.status == 409){
        let actionSnackBar = this.snackBar.open(`Supplier Service Unavailable`, "", {duration: 5000})
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
      this.cartService.getCart()
      this.booksTotal = 0;
      this.booksQuantity = 0;
      this.gamesTotal = 0;
      this.gamesQuantity = 0;
      this.lpsTotal = 0;
      this.lpsQuantity = 0;
    });
  }

  ngOnDestroy(): void {
    this.cartService.pageRequest.next(null);
    this.cartService.cartArticlesBS.next(null);
    this.cartService.cartBS.next(null);
    this.subscriptionRegistry.forEach(subscription => subscription.unsubscribe())
  }

  getNext($event: PageEvent) {
    console.log($event)
  }

  deleteOrderItem(orderItem: OrderItemDTO) {
    this.cartService.delete(orderItem)
    this.cartService.getCart();
  }
}
// this.cartService.getCartArticles(1, 5).subscribe(cartArticles => {
//   console.log(cartArticles)
//   this.totalArticles = cartArticles.totalArticles;
//   this.currentPage = cartArticles.currentPage-1;
//   this.totalPages = cartArticles.totalPages;
//   this.openOrder.orderItems.forEach(orderItem => {
//     orderItem.article = cartArticles.articles.find(article => {
//       return article.type.toUpperCase() == orderItem.articleType && article.id == orderItem.articleId;
//     })
//   })
//
//   this.displayedOrderItems = this.openOrder.orderItems.filter(value => {
//     return !!value.article
//   })
//   console.log(this.displayedOrderItems)
//   this.dataSource.data = this.displayedOrderItems;
//
// })
