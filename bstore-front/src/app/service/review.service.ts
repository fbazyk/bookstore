import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {MatSnackBar} from "@angular/material/snack-bar";
import {environment} from "../../environments/environment";
import {BehaviorSubject} from "rxjs";
import {Review} from "../model/Review";

@Injectable({
  providedIn: 'root'
})
export class ReviewService {

  public reviews: BehaviorSubject<Review[]> = new BehaviorSubject<Review[]>([{
    description: "asdf",
    rating: 10,
  }]);
  constructor(private http: HttpClient,
              public snackBar: MatSnackBar) {
  console.log("REVIEW SERVICE INITIALIZED")
  }

  //TODO
  //TODO

  getReviews(type: string, id: number) {
    this.http.get(`${environment.apiUrl}/reviews/${type}/${id}`, {observe: "body", responseType:"json"})
      .subscribe((reviews:Review[]) => {
        console.log(reviews)
        this.reviews.next(reviews);
    },error => {
        console.log(error);
      })
  }
}
