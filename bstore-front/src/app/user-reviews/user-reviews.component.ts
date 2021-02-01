import {Component, OnDestroy, OnInit} from '@angular/core';
import {ReviewService} from "../service/review.service";
import {Review} from "../model/Review";
import {Subscription} from "rxjs";
import {ArticleService} from "../service/article.service";
import {Article} from "../model/Articles";

@Component({
  selector: 'app-user-reviews',
  templateUrl: './user-reviews.component.html',
  styleUrls: ['./user-reviews.component.css']
})
export class UserReviewsComponent implements OnInit {

  subscriptions: Subscription[] = [];
  userReviews: Review[] = [];

  constructor(private reviewService: ReviewService,
              private articleService: ArticleService) {
  }

  ngOnInit(): void {
    let reviewsSubscription = this.reviewService.userReviews.subscribe(reviews => {
      if (!!reviews) {
        console.log(reviews);
        this.userReviews = reviews;
        this.userReviews.forEach(review => {
          this.articleService.getArticleFromServer(review.articleType, review.id).subscribe((article:Article) => {
            review.articleTitle = article.title;
          })
        })
      }
    })
    this.reviewService.getReviewsForUser();
    this.subscriptions.push(reviewsSubscription)
  }

  ngOnDestroy() {
    this.subscriptions.forEach(subscription => subscription.unsubscribe())
  }
}
