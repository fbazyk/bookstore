import { Injectable } from '@angular/core';
import {UserService} from "../user.service";
import {CanActivate, Router} from "@angular/router";
import {Observable, of} from "rxjs";
import { tap, map } from 'rxjs/operators';
import {User} from "../model/User";

@Injectable({
  providedIn: 'root'
})
export class UserGuardService implements CanActivate {

  constructor(public user: UserService, public router: Router) {}

  canActivate(): boolean {
    console.log("User Guard")
    if( this.user.isUserOrAdmin()){
      return true;
    } else {
      this.router.navigate(['login']);
      return false;
    }
  }
}
