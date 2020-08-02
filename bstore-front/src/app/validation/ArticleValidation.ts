import {AbstractControl, FormGroup, ValidatorFn} from "@angular/forms";
import {require} from "isbnjs";
let ISBN = require('isbnjs');
declare var require: any;

/**
 * ISBN form value is valid if it is:
 * EMPTY (!!control.value)
 * Parsed ISBN is either ISBN10 or ISBN13
 *
 * since isbnjs returns null with wrong isbn, it has to be checked for
 * */
export function correctISBNValidator(): ValidatorFn {
  return (control: AbstractControl): {[key: string]: any} | null => {
    // ISBN entry is valid when
    if(!!control.value && control.parent.controls['type'].value == 'book'){
      let result = ISBN.parse(control.value);
      if(!!result){
        return (result?.isIsbn10() || result?.isIsbn13())? null : {badisbn: true};
      } else return  {noisbn: true}
    } else return null;
  };
}

/**
 * Article has to have a type in order to be saved in DB
 * */
export function correctNewArticleTypeValidator(): ValidatorFn {
  console.log("type validation calling")
  return (control: AbstractControl): {[key: string]: any} | null => {
    console.log(control.dirty && control.value !=='all')
    return  control.value != 'all' ? null : {selectTypeError: true};
  };
}

/**
 * Article has to have a type in order to be saved in DB
 * */
export function correctNewArticleTypeValidator2(): ValidatorFn {
  console.log("type validation calling")
  return (control: AbstractControl): {[key: string]: any} | null => {
    console.log(control.dirty && control.value !=='all')
    return  control.value != 'all' ? null : {selectTypeError: true};
  };
}
