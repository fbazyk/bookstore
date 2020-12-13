import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {MatSnackBar} from "@angular/material/snack-bar";
import {environment} from "../../environments/environment";
import {BehaviorSubject} from "rxjs";
import {Review} from "../model/Review";
import {AddReviewDTO} from "../model/AddReviewDTO";

@Injectable({
  providedIn: 'root'
})
export class ReviewService {

  public reviews: BehaviorSubject<Review[]> = new BehaviorSubject<Review[]>(null);

  constructor(private http: HttpClient,
              public snackBar: MatSnackBar) {
    console.log("REVIEW SERVICE INITIALIZED")
  }

  //TODO
  //TODO

  getReviews(type: string, id: number) {
    console.log()
    this.http.get(`${environment.apiUrl}/reviews/${type}/${id}`, {observe: "body", responseType: "json"})
      .subscribe((reviews: Review[]) => {
        // console.log(reviews)
        if(!!reviews){
          this.reviews.next(reviews);

        }
      }, error => {
        console.log(error);
      })
  }

  submit(formgroup: any, articleType: string, articleId: number) {
    console.log(formgroup.review);
    console.log(formgroup.rating)
    let addReview: AddReviewDTO = {
      articleId: articleId,
      articleType: articleType,
      rating: formgroup.rating,
      description: formgroup.review,
    }
    this.http.post(`${environment.apiUrl}/reviews/add`,
      addReview,
      {observe: "response", responseType: "json"})
      .subscribe(value => {
        this.getReviews(articleType, articleId)
        this.snackBar.open("Success", '', {duration:5000})
      }, error => {
        this.snackBar.open("Unable to update review", '', {duration:5000})
        console.log("SOMETHING WENT WRONG")
      })
  }
}
