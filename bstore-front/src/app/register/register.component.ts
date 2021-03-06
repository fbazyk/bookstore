import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {debounceTime, switchMap, tap} from "rxjs/operators";
import {MatSnackBar} from "@angular/material/snack-bar";
import {Router} from "@angular/router";

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;

  constructor(private formBuilder: FormBuilder,
              private http: HttpClient,
              public router: Router,
              public snackBar: MatSnackBar,) {
  }

  ngOnInit(): void {
    console.log(environment.apiUrl)
    console.log(environment.production)
    this.registerForm = this.formBuilder.group({
      username: ['', [Validators.required, Validators.minLength(2)]],
      password: ['', [Validators.required, Validators.minLength(4)]],
      confirmPassword: ['', [Validators.required, Validators.minLength(4)]],
      firstName: ['', [Validators.required]],
      lastName: ['', [Validators.required]],
    })
    let subscription =
      this.registerForm.controls.username.valueChanges
        .pipe(debounceTime(1000))
        .subscribe(usernameToCheck => {
          console.log(usernameToCheck)
          console.log(usernameToCheck)
          const headers = new HttpHeaders({'No-Auth':'True'});
          // this.http.get(`${environment.apiUrl}/register/${usernameToCheck}`, {responseType: "text"})
          this.http.get(`http://localhost:8081/bookstore/register/${usernameToCheck}`, {headers: headers,responseType: "text"})
            .subscribe(value1 => {
              console.log(value1)
              this.registerForm.controls.username.setErrors(null)
            }, (error: any) => {
              console.log(error)
              console.log(error.message)
              let errorSnackBar = this.snackBar.open(`User already exists`,"", {duration: 2500})
              this.registerForm.controls.username.setErrors({'userExists': true})
            },() => {
              console.log("request complete")
            })
        })
    console.log(subscription)
  }

  submit() {
    console.log("submitting form");
    console.log(this.registerForm.value)
    const headers = new HttpHeaders({'No-Auth': 'True'});

    this.http.post(`${environment.apiUrl}/register`,
      {
        "username": this.registerForm.controls.username.value,
        "password": this.registerForm.controls.password.value,
        "firstName": this.registerForm.controls.firstName.value,
        "lastName": this.registerForm.controls.lastName.value
      }, {headers: headers}).subscribe(value => {
      this.router.navigate(["/login"])
      console.log(value)
    })
  }
}
