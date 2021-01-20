import { Component, OnInit } from '@angular/core';
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {MatTableDataSource} from "@angular/material/table";
import {Article} from "../model/Articles";
import {OrderDTO} from "../model/OrderDTO";
import { saveAs } from 'file-saver';

@Component({
  selector: 'app-display-orders',
  templateUrl: './display-orders.component.html',
  styleUrls: ['./display-orders.component.css']
})
export class DisplayOrdersComponent implements OnInit {
  displayedColumns: string[] = ['id', 'date', 'total', 'invoice'];
  dataSource: MatTableDataSource<OrderDTO> = new MatTableDataSource<OrderDTO>();
  constructor(
    private http: HttpClient
  ) { }

  ngOnInit(): void {
    this.http.get<DisplayOrdersDTO>(`${environment.apiUrl}/orders`, {observe:"body"}).subscribe(value => {
      console.log(value);
      this.dataSource.data = value.orderList;
    })
  }

  getInvoice(order: OrderDTO) {
    let headers = new HttpHeaders();
    headers = headers.set('Accept', 'application/pdf');
    this.http.get(`${environment.apiUrl}/orders/invoice/${order.orderId}`,
      {headers: headers, responseType: "blob"}).subscribe(response => {
      let blob = new Blob([response], {type: "application/pdf"});
      saveAs(blob, `invoice-${order.orderId}.pdf`);
    })
  }
}
export interface DisplayOrdersDTO{
  orderList: OrderDTO[];
}
