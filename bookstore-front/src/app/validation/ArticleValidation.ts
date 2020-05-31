import {AbstractControl, ValidatorFn} from "@angular/forms";
import {require} from "isbnjs";
let ISBN = require('isbnjs');
declare var require: any;

export function correctISBNValidator(): ValidatorFn {
  return (control: AbstractControl): {[key: string]: any} | null => {
    return ISBN.parse(control.value);
  };
}
