import {Injectable} from '@angular/core';
import {HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from "@angular/common/http";
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class HttpBasicAuthInterceptorService implements HttpInterceptor {

  constructor() {
  }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let basicAuthString = localStorage.getItem("basicAuthString");
    if (!!basicAuthString) {
      let updatedReq = req.clone({
        setHeaders: {
          Authorization: basicAuthString,
        }
      })
      return next.handle(updatedReq);
    }
  }
}
