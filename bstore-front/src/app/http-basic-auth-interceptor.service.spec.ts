import { TestBed } from '@angular/core/testing';


/**
 * https://stackoverflow.com/questions/47849258/typeerror-you-provided-undefined-where-a-stream-was-expected
 * */
import { HttpBasicAuthInterceptorService } from './http-basic-auth-interceptor.service';

describe('HttpBasicAuthInterceptorService', () => {
  let service: HttpBasicAuthInterceptorService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HttpBasicAuthInterceptorService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
