import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DisplayOrderArticlesComponent } from './display-order-articles.component';

describe('DisplayOrderArticlesComponent', () => {
  let component: DisplayOrderArticlesComponent;
  let fixture: ComponentFixture<DisplayOrderArticlesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DisplayOrderArticlesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DisplayOrderArticlesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
