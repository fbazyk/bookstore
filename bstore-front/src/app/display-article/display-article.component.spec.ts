import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DisplayArticleComponent } from './display-article.component';

describe('DisplayArticleComponent', () => {
  let component: DisplayArticleComponent;
  let fixture: ComponentFixture<DisplayArticleComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DisplayArticleComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DisplayArticleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
