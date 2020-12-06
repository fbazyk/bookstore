import { Injectable } from '@angular/core';
import {UserService} from "../user.service";
import {CanActivate, Router} from "@angular/router";
import {Observable} from "rxjs";
import { tap, map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserGuardService implements CanActivate {

  constructor(public user: UserService, public router: Router) {}

  canActivate(): Observable<boolean> {
    console.log("User Guard")
    return this.user.isUser().pipe(
      tap(authenticated => {
        if (!authenticated){
          this.router.navigate(['/login']);
        }
      }));
  }
}
