import { Injectable } from '@angular/core';


/**
 * AuthService should provide information wether the current user is authenticated
 *
 * Currenly mocked
 * */
@Injectable({
  providedIn: 'root'
})
export class AuthService {


  constructor() {
  }

  //TODO
  isAuthenticated(): boolean{

    return true;
  }

  authenticate(){

  }



}
