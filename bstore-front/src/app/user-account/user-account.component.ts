import { Component, OnInit } from '@angular/core';
import {UserService} from "../user.service";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {Subscription} from "rxjs";

@Component({
  selector: 'app-user-account',
  templateUrl: './user-account.component.html',
  styleUrls: ['./user-account.component.css']
})
export class UserAccountComponent implements OnInit {

  private subs: Subscription[] = [];
  private addressForm: FormGroup;


  constructor(private userService: UserService,
              private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.addressForm = this.formBuilder.group({
      street : ['', [Validators.required]],
      number : ['', [Validators.required]],
      city : ['', [Validators.required]],
      postcode : ['', [Validators.required]],
      country : ['', [Validators.required]]

    })
    this.userService.currentUser.subscribe((value) => {
      if(!!value && !!value.address){
        console.log(value);
        this.addressForm.patchValue({
          street: value.address.street,
          number: value.address.number,
          city: value.address.city,
          postcode: value.address.postcode,
          country: value.address.country,
        })
      }
    })
  }

  submit(){
    console.log(this.addressForm)
    console.log(this.addressForm.value)
    let updatedAddress = {
      street: this.addressForm.value.street,
      number: this.addressForm.value.number,
      city: this.addressForm.value.city,
      postcode: this.addressForm.value.postcode,
      country: this.addressForm.value.country,
    }
    this.userService.updateAddress(updatedAddress)
  }
}
