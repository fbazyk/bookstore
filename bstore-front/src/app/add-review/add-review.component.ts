import {Component, EventEmitter, OnInit, Output} from '@angular/core';
import {Form, FormBuilder, FormGroup, Validators} from "@angular/forms";
import {ReviewService} from "../service/review.service";
import {ActivatedRoute, ActivatedRouteSnapshot} from "@angular/router";

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
  @Output()
  submitEvent: EventEmitter<any> = new EventEmitter<any>();

  constructor(private fb: FormBuilder,
              private route: ActivatedRoute,
              private reviewService: ReviewService) { }

  ngOnInit(): void {
    this.reviewForm = this.fb.group({
      description: ['', Validators.required],
      rating: [4, Validators.required]
    })
  }

  dismiss() {
    this.dismissEvent.emit(null);
  }

  submit() {
    console.log("ReviewForm submit")
    console.log(this.reviewForm.value)
    console.log(this.route.snapshot.params.type)
    let articleType = this.route.snapshot.params.type.toUpperCase();
    let articleId = this.route.snapshot.params.id;
    this.reviewService.submit(this.reviewForm.value, articleType, articleId);
    // this.reviewService.getReviews(articleType, articleId);
    this.dismissEvent.emit(this.reviewForm.value)
  }
}
