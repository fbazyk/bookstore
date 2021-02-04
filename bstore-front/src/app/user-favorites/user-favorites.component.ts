import { Component, OnInit } from '@angular/core';
import {UserService} from "../user.service";
import {User} from "../model/User";
import {Article} from "../model/Articles";
import {MatTableDataSource} from "@angular/material/table";
import {Review} from "../model/Review";
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";

@Component({
  selector: 'app-user-favorites',
  templateUrl: './user-favorites.component.html',
  styleUrls: ['./user-favorites.component.css']
})
export class UserFavoritesComponent implements OnInit {

  favoriteArticles: Article[] = []
  dataSource: MatTableDataSource<Review> = new MatTableDataSource<Article>();
  displayedColumns: string[] = ['articleid', 'type', 'title', 'price', 'delete'];

  constructor(private userService: UserService,
              private http: HttpClient,
              private router: Router) { }

  ngOnInit(): void {
    this.userService.currentUser.subscribe((user: User) => {
      console.log(user)
      this.favoriteArticles = user.favoriteBooks.concat(user.favoriteGames, user.favoriteLps);
      console.log(this.favoriteArticles)
      this.dataSource.data = this.favoriteArticles;
    })
  }

  openArticle(article: Article) {
    this.router.navigate(['/article/', article.type, article.id])
  }

  unfavorite($event: MouseEvent, article: Article) {
    $event.stopPropagation();
    this.http.post(`${environment.apiUrl}/unfavorite/${article.type}/${article.id}`, article).subscribe(value => {
      console.log(value)
      this.userService.updateUserInfo();
    }, error => {
      console.log(error);
    })
  }
}
