import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup} from "@angular/forms";
import {ActivatedRoute, Router} from "@angular/router";
import {ArticleService} from "../service/article.service";
import {UserService} from "../user.service";
import {Location} from "@angular/common";
import {Subscription} from "rxjs";
import {Article, Book, Game, Lp} from "../model/Articles";

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
  articleForm: FormGroup = new FormGroup({
    firstName: new FormControl()
  });
  constructor(private route: ActivatedRoute,
              private articleService: ArticleService,
              private fb: FormBuilder,
              private router: Router,
              private user: UserService,
              private location: Location) { }

  ngOnInit(): void {
    let routeSub = this.route.params.subscribe(params => {
      this.type = params['type'];
      this.id = +params['id']; // (+) converts string 'id' to a number
      this.article = this.articleService.getArticle(params['type'], params['id']);
    });
    this.subs.push(routeSub);
    //todo create a formbuilder
  }


  submitChanges($event: Event) {
    console.log("Form Submitted",$event)
    //todo process event to produce an object of an Article
    const submittedArticle: Article = null;
    this.articleService.submitArticle(submittedArticle)
  }

  dismissChanges($event: MouseEvent) {
    console.log("Dismiss Changes:", $event)
    this.router.navigate([`/article/${this.type}/${this.id}`])
  }
}
