import {Component, EventEmitter, OnInit, Output} from '@angular/core';
import {Form, FormBuilder, FormGroup, Validators} from "@angular/forms";

@Component({
  selector: 'app-add-review',
  templateUrl: './add-review.component.html',
  styleUrls: ['./add-review.component.css']
})
export class AddReviewComponent implements OnInit {
  ratings: number[] = [
     1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  selected: any = 5;
  reviewForm: FormGroup;

  @Output()
  dismissEvent: EventEmitter<any> = new EventEmitter<any>();

  constructor(private fb: FormBuilder) { }

  ngOnInit(): void {
    this.reviewForm = this.fb.group({
      review: ['', Validators.required],
      rating: [4, Validators.required]
    })
  }

  dismiss() {
    this.dismissEvent.emit(null);
  }

  submit() {
    console.log("ReviewForm submit")
    console.log(this.reviewForm.controls.rating.value)
    console.log(this.reviewForm.controls.review.value)
  }
}
