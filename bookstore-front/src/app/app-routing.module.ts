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


const routes: Routes = [

  {
    path: '',
    component: InventoryComponent,
    canActivate: [ UserGuardService]
  },
  {
    path: 'inventory',
    component: InventoryComponent,
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
  { path:  'login', component:  LoginComponent},
  { path: '**', redirectTo: '' }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }


