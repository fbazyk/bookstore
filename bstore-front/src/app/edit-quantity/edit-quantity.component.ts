import {
  ChangeDetectionStrategy,
  Component,
  ElementRef,
  EventEmitter, HostListener,
  Input,
  OnInit,
  Output,
  ViewChild
} from '@angular/core';
import {OrderItemDTO} from "../model/OrderDTO";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";

@Component({
  selector: 'app-edit-quantity',
  templateUrl: './edit-quantity.component.html',
  styleUrls: ['./edit-quantity.component.css']
})
export class EditQuantityComponent implements OnInit {

  // TODO
  @Input()
  providedItem: OrderItemDTO;
  @Output()
  newItemEvent = new EventEmitter<OrderItemDTO>();

  @ViewChild('quantity') inputQuantity: ElementRef;

  asdf: boolean;

  currentValue: number;
  editQuantityForm: FormGroup

  constructor(
    private fb: FormBuilder,
  ) { }

  ngOnInit(): void {
  //TODO
    console.log(this.providedItem)
    this.currentValue = this.providedItem.quantity;
    this.editQuantityForm = this.fb.group({
      quantity: [this.currentValue]
    });
    // ( < any > this.editQuantityForm.get('quantity')).nativeElement.focus();
    // ( < any > this.editQuantityForm.controls.quantity).nativeElement.focus();
    this.editQuantityForm.controls.quantity.patchValue(this.currentValue);
  }


  submit(){
    this.providedItem.editQuantity = false;
    this.providedItem.quantity = this.editQuantityForm.controls.quantity.value
    this.newItemEvent.emit(this.providedItem);
  }

  dismiss(){
    this.providedItem.editQuantity = false;
    // this.providedItem.quantity = 0
    // this.newItemEvent.emit(this.providedItem)
  }


  // @HostListener('document:click', ['$event'])
  // public documentClick(event: Event): void {
  //   console.log(event)
  //
  //   if(!!this.providedItem.editQuantity){
  //     this.inputQuantity.nativeElement.focus();
  //   }
  //
  //   }

}
