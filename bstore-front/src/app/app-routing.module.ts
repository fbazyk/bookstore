import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {LoginComponent} from "./login/login.component";
import {AppComponent} from "./app.component";
import {UserGuardService} from "./security/user-guard.service";
import {AdminGuardService} from "./security/admin-guard.service";
import {DisplayInventoryComponent} from "./display-inventory/display-inventory.component";
import {InventoryComponent} from "./inventory/inventory.component";
import {DisplayArticleComponent} from "./display-article/display-article.component";
import {Article} from "./model/Articles";
import {EditArticleComponent} from "./edit-article/edit-article.component";
import {RegisterComponent} from "./register/register.component";
import {CartComponent} from "./cart/cart.component";
import {AddArticleComponent} from "./add-article/add-article.component";
import {DisplayOrdersComponent} from "./display-orders/display-orders.component";
import {UserAccountComponent} from "./user-account/user-account.component";


const routes: Routes = [

  {
    path: 'orders',
    component: DisplayOrdersComponent,
    canActivate: [ UserGuardService]
  },
  {
    path: 'account',
    component: UserAccountComponent,
    canActivate: [ UserGuardService]
  },
  {
    path: 'inventory',
    component: InventoryComponent,
    canActivate: [UserGuardService]
  },
  {
    path: 'cart',
    component: CartComponent,
    canActivate: [UserGuardService]
  },
  {
    path: 'article/:type/:id',
    component: DisplayArticleComponent,
    canActivate: [ UserGuardService]
  },
  {
    path: 'article/edit/:type/:id',
    component: EditArticleComponent,
    canActivate: [AdminGuardService]
  },
  {
    path: 'article',
    component: AddArticleComponent,
    canActivate: [AdminGuardService]
  },
  { path:  'login', component:  LoginComponent},
  { path:  'register', component:  RegisterComponent},
  { path:  '', redirectTo:  '/inventory', pathMatch:'full'},

  { path: '**', redirectTo: '/inventory' }

];

@NgModule({
  imports: [RouterModule.forRoot(routes, { relativeLinkResolution: 'legacy' })],
  exports: [RouterModule]
})
export class AppRoutingModule { }


