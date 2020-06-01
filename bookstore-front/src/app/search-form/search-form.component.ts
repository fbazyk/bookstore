import {Component, EventEmitter, Input, OnDestroy, OnInit, Output} from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormControl,
  FormGroup,
  ValidationErrors,
  ValidatorFn,
  Validators
} from "@angular/forms";
import {BehaviorSubject, Subscription} from "rxjs";
import {SearchState, provideEmptySearchState} from "../model/SearchState";
import {require} from "isbnjs";
import {articleType, articleTypes} from "../model/Articles";

let ISBN = require('isbnjs');
declare var require: any;

@Component({
  selector: 'app-search-form',
  templateUrl: './search-form.component.html',
  styleUrls: ['./search-form.component.css']
})
export class SearchFormComponent implements OnInit, OnDestroy {

  /**
   * Events fire directly to BehaviorSubject of parent component
   * */
  @Output()
  newSearch: EventEmitter<SearchState> = new EventEmitter<SearchState>();

  @Input()
  providedState: SearchState;


  private clearFormValue = {
    id: '',
    type: articleTypes[0],
    title: '',
    minprice: '',
    maxprice: '',
  };
  private subs: Subscription[] = new Array<Subscription>();

  articleType = [...articleTypes];
  newState: SearchState = provideEmptySearchState();

  searchForm: FormGroup;
  isbn10a = ISBN.parse('4873113369');
  selectedClass: any;


  constructor(private fb: FormBuilder) {


  }

  ngOnInit(): void {
    console.log(this.isbn10a.asIsbn13());
    console.log(this.isbn10a.isIsbn13());
    console.log(this.isbn10a.isIsbn10());
    this.newSearch.subscribe(next => {
      this.providedState = next;
    });

    this.clearForm();
    this.subscribeToFormChanges();
  }

  /**
   * Produces an event stream every time form is updated,
   * so the newState object is always up to date.
   * One of the sources of Search pipeline
   * */
  private subscribeToFormChanges() {
    let formSub: Subscription = this.searchForm.valueChanges.subscribe(formValues => {
      Object.keys(formValues).filter(formField => {
        return !!formValues[formField];
      }).forEach(formField => {
        this.newState.fields.set(formField, formValues[formField])
      });
    });
    this.subs.push(formSub)
  }

  /**
   * Send existing NewState object to parent component
   * */
  search() {
    this.newSearch.emit(this.newState)
  }

  ngOnDestroy(): void {
    this.subs.forEach(subscription => subscription.unsubscribe())
  }

  /**
   *
   * */
  changeSearch() {
    this.providedState.engaged = false;
  }

  clearForm() {
    this.providedState = new SearchState();

    this.searchForm = this.fb.group(this.clearFormValue);
    this.searchForm.controls['type'].setValidators(Validators.required)
    this.searchForm.controls['id'].setValidators(Validators.min(1))
    this.searchForm.controls['title'].setValidators(Validators.minLength(1))
    this.searchForm.controls['minprice'].setValidators(Validators.min(1))
    this.searchForm.controls['maxprice'].setValidators(Validators.min(1))
    this.searchForm.setValidators([atLeastTwo]);
  }

  hideForm() {
    this.providedState.engaged = true;
  }


}

function atLeastTwo(formGroup) {
  console.log(formGroup)
  console.log(formGroup.value)
  let fieldsWithData = new Map(Object.entries(formGroup.value))
  fieldsWithData.forEach((value, key) => {
    if(!!value){

    } else {
      fieldsWithData.delete(key);
    }
  });
  console.log(fieldsWithData)
    return fieldsWithData.size >=2 ? null : {allOrNoneRequired: true};
}
