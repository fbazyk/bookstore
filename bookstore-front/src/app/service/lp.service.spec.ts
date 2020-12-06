import { TestBed } from '@angular/core/testing';

import { LpService } from './lp.service';

describe('LpService', () => {
  let service: LpService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LpService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
