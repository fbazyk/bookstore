import {Injectable, OnInit} from '@angular/core';
import {BehaviorSubject, Observable, of} from "rxjs";
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {map} from "rxjs/operators";
import {environment} from "../environments/environment";
import {User, UserRole} from "./model/User";
import {Router} from "@angular/router";
import {ExistingUserDTO} from "./model/ExistingUserDTO";
import {Location} from "@angular/common";

/**
 *
 * */
@Injectable({
  providedIn: 'root'
})
export class UserService implements OnInit {

  private allUsersList: User[];
  // allUsersListBS: BehaviorSubject<User[]> = new BehaviorSubject<[User]>([null]);

  private currentUserSubject: BehaviorSubject<User>;
  public currentUser: Observable<User>;

  constructor(private http: HttpClient,
              private location: Location,
              public router: Router) {
    this.location.subscribe(value => {
      console.log(value);
    })
    console.log("USER SERVICE INITIALIZED")
    this.currentUserSubject = new BehaviorSubject<User>(JSON.parse(localStorage.getItem('currentUser')));
    this.currentUser = this.currentUserSubject.asObservable();
    this.currentUser.subscribe((user: User) =>{
      if(!!user){
        console.log(user.role)
        console.log(user)
      }
    })
  }

  public get currentUserValue(): User {
    return this.currentUserSubject.value;
  }

  login(selectedUser: User) {
    console.log("UserService logging in", selectedUser);
    let authHeader: HttpHeaders = this.createHttpAuthHeader(selectedUser)
    return this.http.get<User>(`${environment.apiUrl}/auth`, {
      headers: authHeader,
      // observe: 'response',
      responseType: 'json',
    })
      .subscribe(user => {
        //TODO Store user in the localstorage to retrieve roles
        console.log(user)
        let classUser = Object.assign(new User(), user)
        console.log(classUser)
        this.currentUserSubject.next(classUser)
        this.router.navigate(['/inventory']);

      }, error => {
        console.log(error);
        localStorage.removeItem("basicAuthString")
      });
    console.log("LOGIN COMMITTED")
  }

  createHttpAuthHeader(user: User): HttpHeaders {
    let username = user.username;
    let password = user.password;
    let basicAuthString = `Basic ` + window.btoa(`${username}:${password}`)
    //Put basicAuthString into localstorage
    localStorage.setItem("basicAuthString", basicAuthString);
    let authHeader: HttpHeaders = new HttpHeaders({
      Authorization: basicAuthString,
    })
    return authHeader;
  }

  logout() {
    // remove user from local storage and set current user to null
    localStorage.removeItem('currentUser');
    localStorage.removeItem("basicAuthString");
    this.currentUserSubject.next(null);
  }

  //
  // allUsers(): Array<User> {
  //   console.log("fetching all users")
  //   this.http.get<any>(`${environment.apiUrl}/users`)
  //     .pipe(map(users=>{
  //       console.log(users)
  //       this.allUsersList = users;
  //       this.allUsersListBS.next(users);
  //     })).subscribe();
  //   return this.allUsersList;
  // }

  isAuth(): Observable<boolean> {
    //TODO check if user is authenticated through some jwt token (to implement in UCXX)

    if (!!this.currentUserSubject.getValue()) {
      return of(true);
    } else return of(false);
  }

  ngOnInit(): void {
    console.log("UserService Loaded")
    this.currentUserSubject.subscribe(currentUser => {
      console.log('currentUser')
      console.log(currentUser)
    })
  }

  isUserOrAdmin(): boolean {
    if (!!this.currentUserSubject.getValue()
      && (this.currentUserSubject.getValue().role == UserRole.USER
        || this.currentUserSubject.getValue().role == UserRole.ADMIN)) {
      console.log(this.currentUserSubject.getValue().role);
      return true;
    } else return false;
  }

  isAdmin(): Observable<boolean> {
    if (!!this.currentUserSubject.getValue()
      && this.currentUserSubject.getValue().role == UserRole.ADMIN) {
      console.log(this.currentUserSubject.getValue().role);
      return of(true);
    } else return of(false);
  }

  getUserName(userId: number) {
    return this.http.get(`${environment.apiUrl}/users/id/${userId}`)
  }

  updateUserInfo() {
    this.http.get(`${environment.apiUrl}/users/id/${this.currentUserValue.id}`).subscribe((value: User) => {
      console.log(value)
      this.currentUserSubject.next(value)
    })
  }
}
