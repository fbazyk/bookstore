import {
  AfterViewInit,
  Component,
  ElementRef, EventEmitter,
  Input,
  OnChanges,
  OnInit,
  Output,
  SimpleChanges,
  ViewChild
} from '@angular/core';
import {ArticleService} from "../service/article.service";
import {MatButtonToggleChange, MatButtonToggleGroup} from "@angular/material/button-toggle";
import {BehaviorSubject} from "rxjs";

@Component({
  selector: 'app-category-select',
  templateUrl: './category-select.component.html',
  styleUrls: ['./category-select.component.css']
})
export class CategorySelectComponent implements OnInit {

  @Input()
  providedType: string = 'all';

  @Output()
  // selectedType: EventEmitter<MatButtonToggleChange> = new EventEmitter<MatButtonToggleChange>();
  selectedType: EventEmitter<MatButtonToggleChange> = new EventEmitter();

  constructor() {
  }

  ngOnInit(): void {
    console.log(this.providedType)
    console.log(this.selectedType)
  }

}
