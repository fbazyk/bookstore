import {Component, Input, OnInit} from '@angular/core';
import {Review} from "../model/Review";

@Component({
  selector: 'app-display-review',
  templateUrl: './display-review.component.html',
  styleUrls: ['./display-review.component.css']
})
export class DisplayReviewComponent implements OnInit {

  @Input()
  review: Review

  constructor() { }

  ngOnInit(): void {
    console.log("DISPLAY REVIEW INITIALIZED");
  }

}
