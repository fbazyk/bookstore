import {
  ChangeDetectionStrategy,
  Component,
  ElementRef,
  EventEmitter,
  Input,
  OnInit,
  Output,
  ViewChild
} from '@angular/core';
import {OrderItem} from "../model/OrderDTO";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";

@Component({
  selector: 'app-edit-quantity',
  templateUrl: './edit-quantity.component.html',
  styleUrls: ['./edit-quantity.component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class EditQuantityComponent implements OnInit {

  // TODO
  @Input()
  providedItem: OrderItem;
  @Output()
  newItemEvent = new EventEmitter<string>();

  @ViewChild('quantity') inputQuantity: ElementRef;

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

  ngAfterViewChecked(){
    // this.inputQuantity.nativeElement.focus();

  }

  submit(){
    console.log("this.editQuantityForm.controls.quantity.value");
    this.providedItem.editQuantity = false;
    this.newItemEvent.emit(this.editQuantityForm.controls.quantity.value);
  }

  dismiss(){
    this.providedItem.editQuantity = false;
  }

}
