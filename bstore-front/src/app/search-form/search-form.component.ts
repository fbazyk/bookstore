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
import {ArticleService} from "../service/article.service";
import {SearchDTO} from "../model/SearchDTO";

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
  // @Output()
  // newSearch: EventEmitter<SearchState> = new EventEmitter<SearchState>();
  //
  // @Input()
  // providedState: SearchState;

    private searchDTO: SearchDTO = null;
  private clearFormValue = {
    id: '',
    type: articleTypes[0],
    title: '',
    minprice: '',
    maxprice: '',
    sortby: '',
    sortorder: ''
  };
  private subs: Subscription[] = [];
  showForm: boolean = false;
  articleType = [...articleTypes];
  searchFields = ['type', 'id', 'title', 'price'];
  sortOrder = ['ASC', 'DESC']
  // newState: SearchState;

  searchForm: FormGroup;
  isbn10a = ISBN.parse('4873113369');
  selectedClass: any;


  constructor(
    private fb: FormBuilder,
    private searchService: SearchService,
    private articleService: ArticleService
  ) {


  }

  ngOnInit(): void {
    console.log("INITIALIZE SEARCH FORM")
    this.searchForm = this.fb.group(this.clearFormValue);
    console.log("SEARCH FORM INITIALIZED")
  }
  /**
   * Send existing NewState object to parent component
   * */
  search() {
    this.searchDTO = {
      articleId: this.searchForm.controls.id.value,
      articleType: this.searchForm.controls.type.value,
      searchTitle: this.searchForm.controls.title.value,
      minPrice: this.searchForm.controls.minprice.value,
      maxPrice: this.searchForm.controls.maxprice.value,
      sortBy: this.searchForm.controls.sortby.value,
      sortOrder: this.searchForm.controls.sortorder.value
    }
    console.log("SearchDTO is: {}", this.searchDTO)
    this.showForm=false;
    this.articleService.searchState.next(this.searchDTO)
  }

  ngOnDestroy(): void {
    this.subs.forEach(subscription => subscription.unsubscribe())
  }

  /**
   * Produces an event stream every time form is updated,
   * so the newState object is always up to date.
   * One of the sources of Search pipeline
   * */
  // private subscribeToFormChanges() {
  //   let formSub: Subscription = this.searchForm.valueChanges.subscribe((formValues: Map<String,String>) => {
  //     let fields = new Map<String,String>();
  //     console.log(this.newState)
  //     console.log(formValues);
  //
  //     for(let key in formValues){
  //       if(formValues[key].trim().length>0){
  //         fields.set(key, formValues[key].trim())
  //       }
  //     }
  //     // Object.keys(formValues).filter(formField => {
  //     //   let rawString: String = formValues[formField];
  //     //   return  rawString.trim().length>0;
  //     // }).forEach(formField => {
  //     //   fields.set(formField, formValues[formField])
  //     // });
  //     this.newState.fields = fields;
  //     console.log(this.newState)
  //   });
  //   this.subs.push(formSub)
  // }


  /**
   *
   * */
  changeSearch() {
    this.showForm = true;
  }

  clearForm() {
    // this.searchService.searchState.next(provideEmptySearchState())
    // this.newState = this.providedState;
    // this.searchForm.reset()
    this.searchForm.controls['type'].setValidators(Validators.required)
    this.searchForm.controls['id'].setValidators(Validators.min(1))
    this.searchForm.controls['title'].setValidators(Validators.minLength(1))
    this.searchForm.controls['minprice'].setValidators(Validators.min(1))
    this.searchForm.controls['maxprice'].setValidators(Validators.min(1))
    this.searchForm.setValidators([atLeastTwo]);
    // this.subscribeToFormChanges();
    this.showForm = true;
  }

  hideForm() {
    this.showForm = false;
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
