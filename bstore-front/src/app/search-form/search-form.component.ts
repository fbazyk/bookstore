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
import {SearchService} from "../service/search.service";

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
    sortby: '',
    sortorder: ''
  };
  private subs: Subscription[] = new Array<Subscription>();

  articleType = [...articleTypes];
  searchFields = ['type', 'id', 'title', 'price'];
  sortOrder = ['ASC', 'DESC']
  newState: SearchState;

  searchForm: FormGroup;
  isbn10a = ISBN.parse('4873113369');
  selectedClass: any;


  constructor(private fb: FormBuilder, private searchService: SearchService) {


  }

  ngOnInit(): void {
    console.log(this.isbn10a.asIsbn13());
    console.log(this.isbn10a.isIsbn13());
    console.log(this.isbn10a.isIsbn10());
    // this.newSearch.subscribe(next => {
    //   this.providedState = next;
    // });
    this.clearForm();
  }

  /**
   * Produces an event stream every time form is updated,
   * so the newState object is always up to date.
   * One of the sources of Search pipeline
   * */
  private subscribeToFormChanges() {
    let formSub: Subscription = this.searchForm.valueChanges.subscribe((formValues: Map<String,String>) => {
      let fields = new Map<String,String>();
      console.log(this.newState)
      console.log(formValues);

      for(let key in formValues){
        if(formValues[key].trim().length>0){
          fields.set(key, formValues[key].trim())
        }
      }
      // Object.keys(formValues).filter(formField => {
      //   let rawString: String = formValues[formField];
      //   return  rawString.trim().length>0;
      // }).forEach(formField => {
      //   fields.set(formField, formValues[formField])
      // });
      this.newState.fields = fields;
      console.log(this.newState)
    });
    this.subs.push(formSub)
  }

  /**
   * Send existing NewState object to parent component
   * */
  search() {
    console.log("emitting {}", this.newState)
    this.newState.engaged=true;
    this.newSearch.emit(this.newState)
  }
  /**
   *
   * */
  changeSearch() {
    this.newState.engaged = false;
  }

  clearForm() {
    this.searchService.searchState.next(provideEmptySearchState())
    this.newState = this.providedState;
    this.searchForm = this.fb.group(this.clearFormValue);
    this.searchForm.controls['type'].setValidators(Validators.required)
    this.searchForm.controls['id'].setValidators(Validators.min(1))
    this.searchForm.controls['title'].setValidators(Validators.minLength(1))
    this.searchForm.controls['minprice'].setValidators(Validators.min(1))
    this.searchForm.controls['maxprice'].setValidators(Validators.min(1))
    this.searchForm.setValidators([atLeastTwo]);
    this.subscribeToFormChanges();

  }

  hideForm() {
    this.newState.engaged = true;
  }


  ngOnDestroy(): void {
    this.subs.forEach(subscription => subscription.unsubscribe())
  }


}

function atLeastTwo(formGroup) {
  // console.log(formGroup)
  // console.log(formGroup.value)
  let fieldsWithData = new Map(Object.entries(formGroup.value))
  fieldsWithData.forEach((value, key) => {
    if(!!value){

    } else {
      fieldsWithData.delete(key);
    }
  });
  // console.log(fieldsWithData)
    return fieldsWithData.size >=2 ? null : {allOrNoneRequired: true};
}
