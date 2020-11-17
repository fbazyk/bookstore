import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {debounceTime} from "rxjs/operators";
import {MatSnackBar} from "@angular/material/snack-bar";

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;

  constructor(private formBuilder: FormBuilder, private http: HttpClient, public snackBar: MatSnackBar,) {
  }

  ngOnInit(): void {
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
          this.http.get(`${environment.apiUrl}/register/${usernameToCheck}`, {responseType: "text"})
            .subscribe(value1 => {
              console.log(value1)
              this.registerForm.controls.username.setErrors(null)
            }, (error: HttpErrorResponse) => {
              let errorSnackBar = this.snackBar.open(`User already exists`,"", {duration: 2500})
              this.registerForm.controls.username.setErrors({'userExists': true})
              console.log(error)
              console.log(error.message)
            },() => {
              console.log("request complete")
            })
          console.log(usernameToCheck)
        })
    console.log(subscription)
  }

  submit() {
    console.log("submitting form");
    console.log(this.registerForm.value)
    this.http.post(`${environment.apiUrl}/register`,
      {
        "username": this.registerForm.controls.username.value,
        "password": this.registerForm.controls.password.value,
        "firstName": this.registerForm.controls.firstName.value,
        "lastName": this.registerForm.controls.lastName.value
      }).subscribe(value => {
        console.log(value)
    })
  }
}
