import {AbstractControl, ValidatorFn} from "@angular/forms";
import {require} from "isbnjs";
let ISBN = require('isbnjs');
declare var require: any;

export function correctISBNValidator(): ValidatorFn {
  return (control: AbstractControl): {[key: string]: any} | null => {
    let result: Boolean = ISBN.parse(control.value);
    let notEmpty: Boolean = control.value.toString().trim().length > 0;
    return  (result && notEmpty) ? null : {incorrectIsbn: true};
  };
}

export function correctNewArticleTypeValidator(): ValidatorFn {
  return (control: AbstractControl): {[key: string]: any} | null => {
    return control.value !== 'all' ? null : {selectTypeError: true};
  };
}
