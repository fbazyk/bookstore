import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from "@angular/router";
import {ArticleService} from "../service/article.service";
import {Article, Book, Game, Item, Lp} from "../model/Articles";
import {Form, FormBuilder, FormGroup} from "@angular/forms";
import {UserService} from "../user.service";
import {Location} from '@angular/common';
import {Subscription} from "rxjs";
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {ReviewService} from "../service/review.service";
import {Review} from "../model/Review";
import {ExistingUserDTO} from "../model/ExistingUserDTO";
import {UserRole as UserRole} from "../model/User"
import {MatSlideToggleChange} from "@angular/material/slide-toggle";
import {OrderItemDTO} from "../model/OrderDTO";

@Component({
  selector: 'app-display-article',
  templateUrl: './display-article.component.html',
  styleUrls: ['./display-article.component.css']
})
export class DisplayArticleComponent implements OnInit, OnDestroy {
  private sub: any;
  private subs: Subscription[] = new Array<Subscription>();
  type: string;
  id: number;
  article: Article = {
    id: 0,
    type: "BOOK",
    title: "",
    price: 0
  };
  reviews: Review[];
  form: Form;
  reviewsExist: boolean;
  isFavorite: boolean = false;

  showAdminControls: boolean = false;
  showAddReview: boolean = false;

  constructor(private route: ActivatedRoute,
              private articleService: ArticleService,
              private fb: FormBuilder,
              private http: HttpClient,
              private router: Router,
              private userService: UserService,
              private reviewService: ReviewService,
              private location: Location) {
  }

  ngOnInit(): void {
    let routeSub = this.route.params.subscribe(params => {
      this.type = params['type'];
      this.id = +params['id']; // (+) converts string 'id' to a number
      this.articleService.getArticleFromServer(params['type'], params['id']).subscribe((value: Article) => {
        this.article = value;
        this.applyFavorite()
      });


      this.reviewService.getReviews(params['type'], params['id']);
    });
    let userIsAdminSub = this.userService.isAdmin().subscribe(isAdmin => {
      this.showAdminControls = isAdmin
    });
    let userSub = this.userService.currentUser.subscribe(value => {
      if (!!value) {
        this.applyFavorite()
      }
    })


    let reviewSub = this.reviewService.reviews.subscribe(reviews => {
      if (!!reviews) {
        // console.log(reviews)
        this.reviews = reviews;
        this.reviewsExist = reviews.length > 0;
        this.reviews.forEach(review => {
          // console.log(review)
          if (!!review) {
            this.userService.getUserName(review.userId).subscribe((existingUserDTO: ExistingUserDTO) => {
              // console.log(existingUserDTO);
              review.userName = existingUserDTO.username;
            });
          }
        })
      }
    })
    this.subs.push(reviewSub);
    this.subs.push(userSub);
    this.subs.push(routeSub);
    this.subs.push(userIsAdminSub);
  }

  applyFavorite() {
    switch (this.article.type.toUpperCase()) {
      case 'BOOK': {
        console.log(this.article.type)
        this.isFavorite = this.userService.currentUserValue.favoriteBooks.map((value: Article) => value.id).includes(this.article.id)
        break;
      }
      case 'GAME': {
        this.isFavorite = this.userService.currentUserValue.favoriteGames.map((value: Article) => value.id).includes(this.article.id)
        break;
      }
      case 'LP': {
        this.isFavorite = this.userService.currentUserValue.favoriteLps.map((value: Article) => value.id).includes(this.article.id);
        break;
      }
    }
  }

  ngOnDestroy(): void {
    this.reviewService.reviews.next(null)
    this.subs.forEach(subscription => subscription.unsubscribe())
  }

  getAuthor() {
    if ("author" in this.article) {
      return this.article.author
    }
  }

  /**
   * Navigate to Edit Article Component
   * Protected by AdminGuard
   * Option not shown for role=USER
   * */
  doEdit() {
    // console.log("edit button pressed");
    //do i navigate to a different route?
    //for ex. /article/edit/:type/:id
    // and show different component
    //I guess option 1 is better due to separation of concerns
    this.router.navigate(['/article/edit', this.type, this.id]);

    //or do I add fields in the same component, instantiate the form, etc...
    //it grows too big here then, abort this path.
  }

  /**
   * Send the request to back-end to delete the article with the type and id
   * Option not shown for role=USER
   * */
  doDelete() {
    // console.log("DISPLAY-ARTICLE-COMPONENT \n delete button pressed");
    this.articleService.delete(this.type, this.id);
    const loadingSub = this.articleService.isLoading.subscribe(loading => {
      if (!loading) {
        this.router.navigate(['/inventory'])
      }
    });
    this.subs.push(loadingSub);
  }

  navigate() {
    this.router.navigate(['/inventory']);
  }

  addToCart() {
    let orderItem: OrderItemDTO = {
      articleType: this.article.type.toUpperCase(),
      articleId: this.article.id,
      quantity: 1
    };
    this.http.post(`${environment.apiUrl}/orderitem`, orderItem, {
      observe: "response",
      responseType: "json"
    }).subscribe(response => {
      console.log("OrderItemDTO Response")
      console.log(response)
      this.router.navigate(['/inventory'])
    }, (error: HttpErrorResponse) => {
      console.log(error)
    })
    console.log("AddToCart Posted")
    console.log(orderItem)
  }

  displayAddReview() {
    this.showAddReview = true;
  }

  _reviewsExist() {
    return !!this.reviews && this.reviews.length > 0;
  }

  favorite($event: MatSlideToggleChange, article: Article) {
    if ($event.checked) {
      this.http.post(`${environment.apiUrl}/favorite/${article.type}/${article.id}`, article).subscribe(value => {
        console.log(value)
        //Update User object on success
        this.userService.updateUserInfo();
      }, error => {
        console.log(error);
      })
    } else {
      this.http.post(`${environment.apiUrl}/unfavorite/${article.type}/${article.id}`, article).subscribe(value => {
        console.log(value)
        this.userService.updateUserInfo();
      }, error => {
        console.log(error);
      })
    }
  }
}
