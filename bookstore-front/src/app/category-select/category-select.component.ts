import {AfterViewInit, Component, ElementRef, Input, OnChanges, OnInit, SimpleChanges, ViewChild} from '@angular/core';
import {ArticleService} from "../service/article.service";
import {MatButtonToggleChange, MatButtonToggleGroup} from "@angular/material/button-toggle";

@Component({
  selector: 'app-category-select',
  templateUrl: './category-select.component.html',
  styleUrls: ['./category-select.component.css']
})
export class CategorySelectComponent implements OnInit {

  togglevalues: Array<string> = [
    'all',
    'books',
    'games',
    'lps'
  ];

  @ViewChild('group') element: MatButtonToggleGroup;
  categoryToggle: string = 'all';

  constructor(private articleS: ArticleService,
              private _elementRef: ElementRef) {
  }


  ngOnInit(): void {
  }


  do($event: MatButtonToggleChange) {
    this.articleS.selectedCategory.next($event.value)
  }

}
