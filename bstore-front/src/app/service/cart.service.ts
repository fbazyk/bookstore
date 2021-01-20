import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {environment} from "../../environments/environment";
import {OrderDTO, OrderItemDTO} from "../model/OrderDTO";
import {BehaviorSubject, Observable} from "rxjs";
import {Article} from "../model/Articles";
import {withLatestFrom} from "rxjs/operators";
import {PageRequest} from "../model/ArticlesPage";

@Injectable({
  providedIn: 'root'
})
export class CartService {

  public cartBS: BehaviorSubject<OrderDTO> = new BehaviorSubject<OrderDTO>(null);
  public openOrder: Observable<OrderDTO> = this.cartBS.asObservable();
  public displayedArticles: BehaviorSubject<OrderDTO> = new BehaviorSubject<OrderDTO>(null);
  public cartArticlesBS: BehaviorSubject<CartArticles> = new BehaviorSubject<CartArticles>(null);
  pageRequest: BehaviorSubject<PageRequest> =new BehaviorSubject<PageRequest>(null);
  constructor(private http: HttpClient,
              private router: Router,) {

    this.pageRequest.subscribe(value => {
      if(!!value){
        console.log(value)
        this.getCartArticles(value.pageIndex, value.pageSize).subscribe(value1 => {
          console.log(value1);
          this.cartArticlesBS.next(value1)
        })
      }
    })
  }

  getCart() {
    this.http.get(`${environment.apiUrl}/cart`, {observe: "body", responseType: "json"})
      .subscribe((value: OrderDTO) => {
        console.log("OpenOrder:")
        console.log(value)
        this.cartBS.next(value);
      })
  }

  updateQuantity(orderItem: OrderItemDTO) {
    console.log("CART-SERVICE::Update Quantity")
    console.log(orderItem)
    this.http.post(`${environment.apiUrl}/orderitem`, orderItem)
      .subscribe(value => {
        console.log(value)
        this.getCart()
      }, error => {
        console.log(error)
      })
  }

  getCartArticles(page: number, psize: number) {
    return this.http.get<CartArticles>(`${environment.apiUrl}/cartarticles?page=${page}&psize=${psize}`);

  }

  delete(orderItem: OrderItemDTO) {
    let oi: OrderItemDTO = {
      articleId: orderItem.articleId,
      articleType: orderItem.articleType
    }
    this.http.delete(`${environment.apiUrl}/orderitem/${orderItem.articleType}/${orderItem.articleId}`).subscribe(value => {
      console.log(value);
      this.getCart()
    }, error => {
      console.log(error)
    })
  }
}

export interface CartArticles {
  articles: Article[],
  totalArticles: number,
  currentPage: number,
  totalPages: number
}
