import {Component, OnInit} from '@angular/core';
import {UserService} from "../user.service";
import {User} from "../model/User";
import {FormBuilder, Validators} from "@angular/forms";
import {BehaviorSubject} from "rxjs";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginForm: any;
  allUsers: Array<User>;
  allUsersBS: BehaviorSubject<[User]> = new BehaviorSubject<[User]>([null]);

  constructor(private userService: UserService,
              private formBuilder: FormBuilder){
    console.log("loaded login component");
    this.loginForm = this.formBuilder.group({
      userList: [this.allUsers]
    });
  }

  ngOnInit(): void {
    console.log("Login Initialized")
    //load users


    this.subscribeToUserListBS();
    this.userService.allUsers();
  }

  subscribeToUserListBS() {
    console.log("subscribing to all users");
    this.userService.allUsersListBS.subscribe(userList => {
      console.log("User List:")
      console.log(userList)
      this.allUsers = userList;
      this.loginForm.patchValue({"userList": this.allUsers})
    });
  }

  login(value:any) {
    console.log("Log In Action Triggered")
    console.log("Value: userList", this.loginForm.value.userList);
    let selectedUser:User = this.loginForm.value.userList;


    //pass form results to userService
    //have a form with Select objects
    //formgroup etc...
    this.userService.login(selectedUser);
  }

}
