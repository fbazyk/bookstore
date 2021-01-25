import {Component, Inject, Input, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {OrderService} from "../service/order.service";
import {ArticleService} from "../service/article.service";
import {OrderDTO, OrderItemDTO} from "../model/OrderDTO";
import {Article} from "../model/Articles";
import {MatTableDataSource} from "@angular/material/table";

@Component({
  selector: 'app-display-order-articles',
  templateUrl: './display-order-articles.component.html',
  styleUrls: ['./display-order-articles.component.css']
})
export class DisplayOrderArticlesComponent implements OnInit {

  dataSource: MatTableDataSource<OrderItemDTO> = new MatTableDataSource<OrderItemDTO>();
  displayedColumns = ['title', 'price', 'quantity', 'itemtotal'];

  constructor(@Inject(MAT_DIALOG_DATA) public data: { order: OrderDTO },
              private orderService: OrderService,
              private dialogRef: MatDialogRef<DisplayOrderArticlesComponent>,
              private articleService: ArticleService
  ) {
  }

  ngOnInit(): void {
    for (let orderItem of this.data.order.orderItems) {
      this.articleService.getArticleFromServer(orderItem.articleType, orderItem.articleId)
        .subscribe((value: Article) => {
          orderItem.title = value.title
        })
    }
    this.dataSource.data = this.data.order.orderItems;

  }
  close(){
    this.dialogRef.close();
  }

}
