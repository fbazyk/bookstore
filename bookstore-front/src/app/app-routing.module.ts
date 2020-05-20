import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {LoginComponent} from "./login/login.component";
import {AppComponent} from "./app.component";
import {UserGuardService} from "./security/user-guard.service";
import {AdminGuardService} from "./security/admin-guard.service";
import {DisplayInventoryComponent} from "./display-inventory/display-inventory.component";


const routes: Routes = [

  {
    path: '',
    component: AppComponent,
    canActivate: []
  },
  {
    path: 'inventory',
    component: DisplayInventoryComponent,
    canActivate: [AdminGuardService]
  },
  { path:  'login', component:  LoginComponent},
  { path: '**', redirectTo: '' }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

//TODO router guards

