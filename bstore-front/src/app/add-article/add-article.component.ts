import { Component, OnInit } from '@angular/core';
import {Subscription} from "rxjs";
import {Article, articleTypes, gameGenres, lpGenres, StorageLocation} from "../model/Articles";
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {correctISBNValidator} from "../validation/ArticleValidation";
import {ActivatedRoute, Router} from "@angular/router";
import {ArticleService} from "../service/article.service";
import {UserService} from "../user.service";
import {Location} from "@angular/common";

@Component({
  selector: 'app-add-article',
  templateUrl: './add-article.component.html',
  styleUrls: ['./add-article.component.css']
})
export class AddArticleComponent implements OnInit {

   //TODO 1 Init form based on the state of the selector
  //TODO 2 preserve title, price between type changes
  //TODO 3 Send a post request with the generated objects

  private subs: Subscription[] = new Array<Subscription>();
  // type: string;
  // id: number;
  article: Article = {
    id: 0,
    type: 'all',
    title: 'Please Enter Title',
  };
  bookForm: boolean = false;
  gameForm: boolean = false;
  lpForm: boolean = false;

  articleType = [...articleTypes];
  gameGenre = [...gameGenres];
  lpGenre = [...lpGenres];

  articleForm: FormGroup = this.fb.group({
    type: ['', [Validators.required]],
    title: ['', [Validators.minLength(3), Validators.required]],
    price: ['', [Validators.min(0), Validators.required]],
    supplierId: ['', Validators.required],
    author: '',
    isbn: ['', [correctISBNValidator(), Validators.required]],
    pages: ['', Validators.min(0)],
    publisher: ['', Validators.minLength(1)],
    minage: ['', Validators.min(0)],
    genre:  ['', ],
    artist: '',
    location: this.fb.group({
      code: '',
      row: '',
      segment: '',
      level: ''
    })

  });

  constructor(private route: ActivatedRoute,
              private articleService: ArticleService,
              private fb: FormBuilder,
              private router: Router,
              private user: UserService,
              private location: Location) {

  }

  ngOnInit(): void {
    this.subscribeToTypeValueChanges()
  }

  subscribeToTypeValueChanges(){
    this.articleForm.controls.type.valueChanges.subscribe(type => {
      console.log(type)
      this.article.type = type;

      if(type == 'all'){
        this.bookForm = false;
        this.gameForm = false;
        this.lpForm = false;
      }

      if(type == 'book'){
        this.populateBookForm()
      }
      if(type == 'game'){
        this.populateGameForm()
      }
      if(type == 'lp'){
        this.populateLPForm()
      }
    });
  }

  populateBookForm(){
    this.bookForm = true;
    this.gameForm = false;
    this.lpForm = false;

    this.articleForm = this.fb.group({
      type: [this.article.type, [Validators.required]],
      title: [this.article.title, [Validators.minLength(3), Validators.required]],
      price: ['', [Validators.min(0), Validators.required]],
      supplierId: ['', Validators.required],
      author: '',
      isbn: ['', [correctISBNValidator(), Validators.required]],
      pages: ['', Validators.min(0)],
      location: this.fb.group({
        code: '',
        row: '',
        segment: '',
        level: ''
      })
    });
    this.subscribeToTypeValueChanges()
  }

  populateGameForm(){
    this.bookForm = false;
    this.gameForm = true;
    this.lpForm = false;
    this.articleForm = this.fb.group({
      type: [this.article.type, [Validators.required]],
      title: [this.article.title, [Validators.minLength(3), Validators.required]],
      price: ['', [Validators.min(0), Validators.required]],
      supplierId: ['', Validators.required],
      publisher: ['', Validators.minLength(1)],
      minage: ['', Validators.min(0)],
      genre:  ['', [Validators.required]],
      location: this.fb.group({
        code: '',
        row: '',
        segment: '',
        level: ''
      })
    });
    this.subscribeToTypeValueChanges()
  }

  populateLPForm(){
    this.bookForm = false;
    this.gameForm = false;
    this.lpForm = true;
    this.articleForm = this.fb.group({
      type: [this.article.type, [Validators.required]],
      title: [this.article.title, [Validators.minLength(3), Validators.required]],
      price: [this.article.price, [Validators.min(0), Validators.required]],
      supplierId: ['', Validators.required],
      genre:  ['', [Validators.required]],
      artist: '',
      location: this.fb.group({
        code: '',
        row: '',
        segment: '',
        level: ''
      })
    });
    this.subscribeToTypeValueChanges()
  }


  /**
   * Has to run after the response from the ArticleService has arrived.
   * Form may be initialized before with empty object.
   * */
  populateForm() {
    // this.articleForm.get('type').setValidators([Validators.required, correctNewArticleTypeValidator]);
    this.articleForm.patchValue({
      id: this.article.id,
      type: this.article.type,
      title: this.article.title,
      price: this.article.price,
      supplierId: this.article.supplierId,
    });

    console.log(this.articleForm.get('type'))
    // this.articleForm.controls['type'].setValidators([Validators.required, correctNewArticleTypeValidator]);
    // this.articleForm.controls['type'].markAsDirty();
    console.log(this.articleForm.get('type'))
    switch (this.article.type) {
      case 'book': {
        this.articleForm.patchValue({
          author: this.article.author,
          isbn: this.article.isbn,
          pages: this.article.pages
        });
        this.articleForm.controls['isbn'].setValidators([correctISBNValidator(), Validators.required])
        break;
      }
      case 'game': {
        this.articleForm.patchValue({
          publisher: this.article.publisher,
          minage: this.article.minage,
          genre: this.article.genre
        });
        // this.articleForm.controls['isbn'].setValidators([])
        this.articleForm.controls['isbn'].clearValidators()
        this.articleForm.controls['genre'].setValidators(Validators.required)
        break;
      }
      case 'lp': {
        this.articleForm.patchValue({
          artist: this.article.artist,
          genre: this.article.genre
        })
        this.articleForm.controls['isbn'].clearValidators()
        this.articleForm.controls['genre'].setValidators(Validators.required)
      }
    }

    this.articleForm.controls['price'].setValidators(Validators.required)


    this.articleForm.controls['title'].valueChanges.subscribe(value => {
      this.article.title = value
    });
  }

  dismissChanges($event: MouseEvent) {
    console.log("Dismiss Changes:", $event)
    console.log(this.location.getState())
    console.log(this.location.path())
    this.location.back()
    // console.log(this.article)
    // if (!!this.id) {
    //   this.router.navigate([`/article/${this.type}/${this.id}`])
    // } else {
    //   this.router.navigate(['/bookstore']);
    // }
  }

  submitChanges($event: Event) {
    console.log("form valid", this.articleForm.valid);
    console.log("form valid", this.articleForm.value);

    if (this.articleForm.valid) {
      this.article.title = this.articleForm.get('title').value;
      this.article.price = this.articleForm.get('price').value;
      this.article.supplierId = this.articleForm.get('supplierId').value;
      this.article.location = new StorageLocation();
      this.article.location.code = this.articleForm.get('location.code').value;
      this.article.location.row = this.articleForm.get('location.row').value;
      this.article.location.segment = this.articleForm.get('location.segment').value;
      this.article.location.level = this.articleForm.get('location.level').value;
      switch (this.article.type) {
        case 'book': {
          this.article.author = this.articleForm.get('author').value;
          this.article.isbn = this.articleForm.get('isbn').value;
          this.article.pages = this.articleForm.get('pages').value;
          break;
        }
        case 'game': {
          this.article.publisher = this.articleForm.get('publisher').value;
          this.article.minage = this.articleForm.get('minage').value;
          this.article.genre = this.articleForm.get('genre').value;
          break;
        }
        case 'lp': {
          this.article.artist = this.articleForm.get('artist').value;
          this.article.genre = this.articleForm.get('genre').value;
        }
      }
      console.log("Form Submitted", $event)
      //todo process event to produce an object of an Article
      const valueAtSubmission = this.articleForm.value
      console.log(valueAtSubmission);
      console.log(this.article)
      this.articleService.submitArticle(this.article)
    }

  }

}
