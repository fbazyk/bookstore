import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {BehaviorSubject} from "rxjs";
import {SearchState, provideEmptySearchState} from "../model/SearchState";
import {require} from "isbnjs";
let ISBN = require('isbnjs');
declare var require: any;

@Component({
  selector: 'app-search-form',
  templateUrl: './search-form.component.html',
  styleUrls: ['./search-form.component.css']
})
export class SearchFormComponent implements OnInit {

  /**
   * Events fire directly to BehaviorSubject of parent component
   * */
  @Output()
  newSearch: EventEmitter<SearchState> = new EventEmitter<SearchState>();

  @Input()
  providedState: SearchState;

  newState: SearchState = provideEmptySearchState();

  searchForm: FormGroup;
  isbn10a = ISBN.parse('4873113369');


  constructor() { }

  ngOnInit(): void {
    console.log(this.isbn10a.asIsbn13());
    console.log(this.isbn10a.isIsbn13());
    console.log(this.isbn10a.isIsbn10());
    this.newSearch.subscribe(next =>{
      this.providedState = next;
    })

    this.searchForm = new FormGroup({
      firstName: new FormControl()
    });
  }

  search() {
    //todo take this form data
    //todo create a map with fields that are filled in
    //todo put the map into newState
    let fields: Map<string, string>  = new Map<string, string>()
    // let fiels2: Map<string, string>  = new Map<string, string>([["type", 'book']])
    const newState: SearchState = provideEmptySearchState();
    this.newSearch.emit(newState)
  }

  changeSearch() {
    console.log(this.providedState)
    this.providedState.engaged = false;
    console.log(this.providedState)
  }

  clearForm() {
    console.log(this.providedState)
    this.providedState = new SearchState();
    console.log(this.providedState)
  }
}
