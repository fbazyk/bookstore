import {Component, OnDestroy, OnInit} from '@angular/core';
import {ReviewService} from "../service/review.service";
import {Review} from "../model/Review";
import {Subscription} from "rxjs";
import {ArticleService} from "../service/article.service";
import {Article} from "../model/Articles";
import {MatTableDataSource} from "@angular/material/table";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {Router} from "@angular/router";

@Component({
  selector: 'app-user-reviews',
  templateUrl: './user-reviews.component.html',
  styleUrls: ['./user-reviews.component.css']
})
export class UserReviewsComponent implements OnInit {

  subscriptions: Subscription[] = [];
  userReviews: Review[] = [];
  dataSource: MatTableDataSource<Review> = new MatTableDataSource<Review>();
  displayedColumns: string[] = ['articleid', 'type', 'title', 'description', 'rating', 'edit', 'delete'];
  form: FormGroup = new FormGroup({});
  ratings: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  constructor(private reviewService: ReviewService,
              private fb: FormBuilder,
              private router: Router,
              private articleService: ArticleService) {
  }

  ngOnInit(): void {
    let reviewsSubscription = this.reviewService.userReviews.subscribe(reviews => {
      if (!!reviews) {
        console.log(reviews);
        this.userReviews = reviews;
        this.userReviews.forEach(review => {
          this.articleService.getArticleFromServer(review.articleType, review.articleId).subscribe((article:Article) => {
            review.articleTitle = article.title;
          })
        })
        this.dataSource.data = reviews;
      }
    })
    this.reviewService.getReviewsForUser();
    this.subscriptions.push(reviewsSubscription)
  }

  ngOnDestroy() {
    this.subscriptions.forEach(subscription => subscription.unsubscribe())
  }

  deleteReview(review: Review) {
    this.reviewService.deleteReview(review);
  }

  editReview(review: Review) {
    this.userReviews.forEach(review => review.edit = false)
    review.edit = true
    this.form = this.fb.group({
      description: [review.description, Validators.required],
      rating: [review.rating, Validators.required]
    })
  }

  dismiss($event: MouseEvent, review: Review) {
    review.edit = false;
  }

  submitReview($event: MouseEvent, review: Review) {
    console.log(review);
    console.log(this.form.value);
    this.reviewService.submit(this.form.value, review.articleType, review.articleId);
    review.edit = false;
  }

  openArticle(review: Review) {
    this.router.navigate(['/article/', review.articleType, review.articleId]);
  }
}
