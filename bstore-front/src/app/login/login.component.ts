import {Component, OnDestroy, OnInit} from '@angular/core';
import {UserService} from "../user.service";
import {User} from "../model/User";
import {AbstractControl, FormBuilder, ValidatorFn, Validators} from "@angular/forms";
import {BehaviorSubject, Subscription} from "rxjs";
import {Router} from "@angular/router";
import {MatSnackBar} from "@angular/material/snack-bar";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy {

  private subs: Subscription[] = new Array<Subscription>();
  loginForm: any;
  allUsers: Array<User>;
  allUsersBS: BehaviorSubject<[User]> = new BehaviorSubject<[User]>([null]);

  constructor(private userService: UserService,
              private formBuilder: FormBuilder,
              public snackBar: MatSnackBar,
              public router: Router){
    console.log("loaded login component");
    this.loginForm = this.formBuilder.group({
      userList: [this.allUsers, Validators.required],
      password: ['', Validators.required]
    }, {
      validators: [Validators.required]
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
    const userSub = this.userService.allUsersListBS.subscribe(userList => {
      console.log("User List:");
      console.log(userList);
      this.allUsers = userList;
      this.loginForm.patchValue({"userList": this.allUsers})
    });
    this.subs.push(userSub);
  }

  login() {
    if(this.loginForm.valid){
      let password = this.loginForm.value.password;
      console.log('password', password);
      console.log("Log In Action Triggered")
      console.log("Value: userList", this.loginForm.value.userList);
      let selectedUser:User = this.loginForm.value.userList;


      //pass form results to userService
      //have a form with Select objects
      //formgroup etc...
      this.userService.login(selectedUser);
      this.router.navigateByUrl('/inventory');
    }
    else {
      let failureSnackBar = this.snackBar.open(`Please Check Form`,"", {duration: 2500})
    }
  }

  ngOnDestroy(): void {
    this.subs.forEach(value => value.unsubscribe());
  }


}


function expectCorrectPasswordValidator(asdf: string): ValidatorFn {
  return (control: AbstractControl): {[key: string]: any} | null => {
    console.log (asdf)
    console.log(control.value)
    return !!control?.value ? null : {selectTypeError: true};
  };
}
