import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {ActivatedRoute, Router} from "@angular/router";
import {ArticleService} from "../service/article.service";
import {UserService} from "../user.service";
import {Location} from "@angular/common";
import {Subscription} from "rxjs";
import {Article, Book, Game, Lp} from "../model/Articles";
import {correctISBNValidator} from "../validation/ArticleValidation";

@Component({
  selector: 'app-edit-article',
  templateUrl: './edit-article.component.html',
  styleUrls: ['./edit-article.component.css']
})
export class EditArticleComponent implements OnInit {

  private subs: Subscription[] = new Array<Subscription>();
  type: string;
  id: number;
  article: Article;
  //todo make a form

  //todo make inputs

  //todo make validation

  //todo go to back-end, api for article/get/put/post/delete
  //based on the input
  articleForm: FormGroup = this.fb.group({
    title: [''],
    price: [''],
    supplierId: [''],
    author: [''],
    isbn: ['', correctISBNValidator()],
    pages: [''],
    publisher: [''],
    minage: [''],
    genre: [''],
    artist: [''],
  });

  constructor(private route: ActivatedRoute,
              private articleService: ArticleService,
              private fb: FormBuilder,
              private router: Router,
              private user: UserService,
              private location: Location) {

  }

  ngOnInit(): void {
    let routeSub = this.route.params.subscribe(params => {
      this.type = params['type'];
      this.id = +params['id']; // (+) converts string 'id' to a number
      this.article = this.articleService.getArticle(params['type'], params['id']);
      this.populateForm();
    });
    this.subs.push(routeSub);
  }


  submitChanges($event: Event) {
    console.log("Form Submitted", $event)
    //todo process event to produce an object of an Article
    const submittedArticle: Article = {
      id: this.article.id,
      type: this.article.type,
      title: this.article.title
    };
    if(this.articleForm.valid){

    }
    const valueAtSubmission = this.articleForm.value
    submittedArticle.id = this.article.id
    submittedArticle.type = this.article.type
    console.log(valueAtSubmission);
    console.log(this.article)
    this.articleService.submitArticle(submittedArticle)
  }

  dismissChanges($event: MouseEvent) {
    console.log("Dismiss Changes:", $event)
    console.log(this.article)
    this.router.navigate([`/article/${this.type}/${this.id}`])
  }

  /**
   * Has to run after the response from the ArticleService has arrived.
   * Form may be initialized before with empty object.
   * */
  populateForm() {
    // this.articleForm = this.fb.group({
    //   id:[this.article.id, Validators.min(1)],
    //
    // })
    this.articleForm.patchValue({
      id: this.article.id,
      title: this.article.title,
      price: this.article.price,
      supplierId: this.article.supplierId,
    });
    switch (this.article.type) {
      case 'book': {
        this.articleForm.patchValue({
          author: this.article.author,
          isbn: this.article.isbn,
          pages: this.article.pages
        });
        break;
      }
      case 'game': {
        this.articleForm.patchValue({
          publisher: this.article.publisher,
          minage: this.article.min_age,
          genre: this.article.genre
        });
        break;
      }
      case 'lp': {
        this.articleForm.patchValue({
          artist: this.article.artist,
          genre: this.article.genre
        })
      }
    }
  }
}
