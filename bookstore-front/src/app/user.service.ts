import {Injectable, OnInit} from '@angular/core';
import {BehaviorSubject, Observable, of} from "rxjs";
import {HttpClient} from "@angular/common/http";
import {map} from "rxjs/operators";
import {environment} from "../environments/environment";
import {User, UserRole} from "./model/User";

/**
 *
 * */
@Injectable({
  providedIn: 'root'
})
export class UserService implements OnInit{

  private allUsersList: User[];
  allUsersListBS: BehaviorSubject<User[]> = new BehaviorSubject<[User]>([null]);

  private currentUserSubject: BehaviorSubject<User>;
  public currentUser: Observable<User>;

  constructor(private http: HttpClient) {
    console.log("USER SERVICE INITIALIZED")
    this.currentUserSubject = new BehaviorSubject<User>(JSON.parse(localStorage.getItem('currentUser')));
    this.currentUser = this.currentUserSubject.asObservable();
    this.allUsersListBS.subscribe(value => {
      console.log("subscribing to bs")
      console.log(value);
    })
  }

  public get currentUserValue(): User {
    return this.currentUserSubject.value;
  }

  login(selectedUser: User) {
    console.log("UserService logging in", selectedUser);
    this.currentUserSubject.next(selectedUser);

    // return this.http.post<any>(`${environment.apiUrl}/users/authenticate`, { username, password })
    //   .pipe(map(user => {
    //     // store user details and jwt token in local storage to keep user logged in between page refreshes
    //     localStorage.setItem('currentUser', JSON.stringify(user));
    //     this.currentUserSubject.next(user);
    //     return user;
    //   }));
  }

  logout() {
    // remove user from local storage and set current user to null
    localStorage.removeItem('currentUser');
    this.currentUserSubject.next(null);
  }


  allUsers(): Array<User> {
    console.log("fetching all users")
    this.http.get<any>(`${environment.apiUrl}/users`)
      .pipe(map(users=>{
        console.log(users)
        this.allUsersList = users;
        this.allUsersListBS.next(users);
      })).subscribe();
    return this.allUsersList;
  }

  isAuth():Observable<boolean>{
    //TODO check if user is authenticated through some jwt token (to implement in UCXX)

    if(!!this.currentUserSubject.getValue()){
      return of(true);
    } else return of(false);
  }

  ngOnInit(): void {
    console.log("ng oninit executed")

    this.allUsers();
    this.allUsersListBS.subscribe(value => {
      console.log(value);
    })
  }

  isUser():Observable<boolean> {
    if(!!this.currentUserSubject.getValue() && (this.currentUserSubject.getValue().role == UserRole.USER || this.currentUserSubject.getValue().role == UserRole.ADMIN )){
      console.log(this.currentUserSubject.getValue().role);
      return of(true);
    }else return of(false);
  }
  isAdmin():Observable<boolean> {
    if(!!this.currentUserSubject.getValue() && this.currentUserSubject.getValue().role == UserRole.ADMIN){
      console.log(this.currentUserSubject.getValue().role);
      return of(true);
    }else return of(false);
  }
}
