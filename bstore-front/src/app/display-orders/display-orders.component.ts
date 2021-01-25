import { Component, OnInit } from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {MatTableDataSource} from "@angular/material/table";
import {Article} from "../model/Articles";
import {OrderDTO} from "../model/OrderDTO";
import { saveAs } from 'file-saver';
import {Router} from "@angular/router";
import {MatSnackBar} from "@angular/material/snack-bar";

@Component({
  selector: 'app-display-orders',
  templateUrl: './display-orders.component.html',
  styleUrls: ['./display-orders.component.css']
})
export class DisplayOrdersComponent implements OnInit {
  displayedColumns: string[] = ['id', 'date', 'total', 'invoice'];
  dataSource: MatTableDataSource<OrderDTO> = new MatTableDataSource<OrderDTO>();
  constructor(
    private http: HttpClient,
    public snackBar: MatSnackBar,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.http.get<DisplayOrdersDTO>(`${environment.apiUrl}/orders`, {observe:"body"}).subscribe(value => {
      console.log(value);
      this.dataSource.data = value.orderList;
    })
  }

  getInvoice(event: MouseEvent, order: OrderDTO) {
    event.stopPropagation();
    let headers = new HttpHeaders();
    headers = headers.set('Accept', 'application/pdf');
    this.http.get(`${environment.apiUrl}/orders/invoice/${order.orderId}`,
      {headers: headers, responseType: "blob"}).subscribe(response => {
      let blob = new Blob([response], {type: "application/pdf"});
      saveAs(blob, `invoice-${order.orderId}.pdf`);
    }, (error: HttpErrorResponse) => {
        console.log(error)
      if(error.status){
        this.snackBar.open("Please enter address", "", {duration: 5000})
        this.router.navigate(['/account']);
      }
    })
  }

  showOrder(event: MouseEvent) {
    //TODO show order
    console.log(event)
  }
}
export interface DisplayOrdersDTO{
  orderList: OrderDTO[];
}
