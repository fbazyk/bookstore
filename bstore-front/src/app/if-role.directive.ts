import {Directive, Input, TemplateRef, ViewContainerRef} from '@angular/core';
import {UserService} from "./user.service";
import {map} from "rxjs/operators";
import {Subscription} from "rxjs";

@Directive({
  selector: '[ifRole]'
})
export class IfRoleDirective {

  subscriptions: Subscription[] = [];
  @Input() public ifRole: Array<string>;

  constructor(private viewContainerRef: ViewContainerRef,
              private templateRef: TemplateRef<any>,
              private userService: UserService) {
  }

  public ngOnInit(): void {

    let sub = this.userService.currentUser
      .subscribe(user => {
        //if user exists (logged-in) and domRole contains his role
        //OR user is null and domRole array is empty
        if ((!!user && this.ifRole.indexOf(user.role) >= 0)
          || (!user && this.ifRole.length == 0)) {
          //show content
          this.viewContainerRef.createEmbeddedView(this.templateRef)
        } else {
          //hide content
          this.viewContainerRef.clear();
        }
      })

    this.subscriptions.push(sub)
  }

  ngOnDestroy() {
    this.subscriptions.forEach(sub => sub.unsubscribe())
  }
}


