import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {ActivatedRoute, Router} from "@angular/router";
import {ArticleService} from "../service/article.service";
import {UserService} from "../user.service";
import {Location} from "@angular/common";
import {Subscription} from "rxjs";
import {Article, articleTypes, Book, Game, gameGenres, Lp, lpGenres, StorageLocation} from "../model/Articles";
import {
  correctISBNValidator,
  correctNewArticleTypeValidator
} from "../validation/ArticleValidation";

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

  articleType = [...articleTypes];
  gameGenre = [...gameGenres];
  lpGenre = [...lpGenres];

  articleForm: FormGroup = this.fb.group({
    type: ['', ],
    title: ['', [Validators.minLength(3), Validators.required]],
    price: ['', [Validators.min(0), Validators.required]],
    supplierId: ['', Validators.required],
    author: '',
    isbn: ['', [correctISBNValidator()]],
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
    let routeSub = this.route.params.subscribe(params => {
      this.type = params['type'];
      this.id = +params['id']; // (+) converts string 'id' to a number
      console.log(this.type, this.id);
      const emptyArticle = {
        type: 'all',
        id: 0,
        title: 'Please Enter Title'
      };
      if (!!params['type'] && !!params['id']) {
        this.articleService.getArticleFromServer(this.type, this.id).subscribe((value: Article) => {
          this.article = value;
          this.populateForm();
        });
      } else {
        this.article = emptyArticle
      }
    });
    this.subs.push(routeSub);
  }

  subscribeToTypeValueChanges(){
    this.articleForm.controls['type'].valueChanges.subscribe(value => {
      this.article.type = value;

      if(value == 'book'){

      }
      if(value == 'game'){

      }
      if(value == 'lp'){

      }
    });
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
      location: {
        code: this.article.location.code,
        row: this.article.location.row,
        segment: this.article.location.segment,
        level: this.article.location.level,
      }
    });
    console.log(this.articleForm)
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
        this.articleForm.controls['genre'].setValidators(Validators.required)
        break;
      }
      case 'lp': {
        this.articleForm.patchValue({
          artist: this.article.artist,
          genre: this.article.genre
        })
        this.articleForm.controls['genre'].setValidators(Validators.required)
      }
    }

    this.articleForm.controls['price'].setValidators(Validators.required)


    this.articleForm.controls['title'].valueChanges.subscribe(value => {
      this.article.title = value
    });
  }

  dismissChanges($event: MouseEvent) {
    this.location.back();
  }

  submitChanges($event: Event) {
    console.log("form valid", this.articleForm.valid)

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
