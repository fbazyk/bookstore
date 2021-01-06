import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DisplayReviewComponent } from './display-review.component';

describe('DisplayReviewComponent', () => {
  let component: DisplayReviewComponent;
  let fixture: ComponentFixture<DisplayReviewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DisplayReviewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DisplayReviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
