import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {MatSnackBar} from "@angular/material/snack-bar";
import {environment} from "../../environments/environment";
import {BehaviorSubject} from "rxjs";
import {Review} from "../model/Review";
import {AddReviewDTO} from "../model/AddReviewDTO";
import {UserService} from "../user.service";

@Injectable({
  providedIn: 'root'
})
export class ReviewService {

  public userReviews: BehaviorSubject<Review[]> = new BehaviorSubject<Review[]>(null)
  public articleReviews: BehaviorSubject<Review[]> = new BehaviorSubject<Review[]>(null);

  constructor(private http: HttpClient,
              private userService: UserService,
              public snackBar: MatSnackBar) {
    console.log("REVIEW SERVICE INITIALIZED")
  }

  //TODO
  //TODO

  getReviewsForArticle(type: string, id: number) {
    console.log()
    this.http.get(`${environment.apiUrl}/reviews/${type}/${id}`, {observe: "body", responseType: "json"})
      .subscribe((reviews: Review[]) => {
        // console.log(reviews)
        if(!!reviews){
          this.articleReviews.next(reviews);

        }
      }, error => {
        console.log(error);
      })
  }

  getReviewsForUser(){
    let userId = this.userService.currentUserValue.id;
    this.http.get(`${environment.apiUrl}/reviews/user/${userId}`).subscribe((value: Review[]) => {
      console.log("Reviews for current user")
      console.log(value)
      this.userReviews.next(value);
    })

  }

  submit(formgroup: any, articleType: string, articleId: number) {
    console.log(formgroup.description);
    console.log(formgroup.rating)
    let addReview: AddReviewDTO = {
      articleId: articleId,
      articleType: articleType,
      rating: formgroup.rating,
      description: formgroup.description,
    }
    this.http.post(`${environment.apiUrl}/reviews/add`,
      addReview,
      {observe: "response", responseType: "json"})
      .subscribe(value => {
        this.getReviewsForArticle(articleType, articleId);
        this.getReviewsForUser();
        this.snackBar.open("Success", '', {duration:5000})
      }, error => {
        this.snackBar.open("Unable to update review", '', {duration:5000})
        console.log("SOMETHING WENT WRONG")
      })
  }

  deleteReview(review: Review) {
    this.http.delete(`${environment.apiUrl}/reviews/${review.id}`).subscribe(value => {
      console.log(value);
      this.getReviewsForUser()
    })
  }
}
