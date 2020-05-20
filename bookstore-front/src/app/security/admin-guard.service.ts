import { Injectable } from '@angular/core';
import {UserService} from "../user.service";
import {CanActivate, Router} from "@angular/router";
import {Observable} from "rxjs";
import {tap} from "rxjs/operators";

@Injectable({
  providedIn: 'root'
})
export class AdminGuardService implements CanActivate {

  constructor(public user: UserService, public router: Router) {}

  canActivate(): Observable<boolean> {
    console.log("Admin Guard")
    return this.user.isAdmin().pipe(
      tap(authenticated => {
        if (!authenticated){
          this.router.navigateByUrl('/login');
        }
      }));
  }
}
