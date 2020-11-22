import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatButtonModule} from "@angular/material/button";
import {MatInputModule} from "@angular/material/input";
import {MatSelectModule} from "@angular/material/select";
import {MatFormFieldModule} from "@angular/material/form-field";

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import {HTTP_INTERCEPTORS, HttpClientModule} from "@angular/common/http";
import { DisplayInventoryComponent } from './display-inventory/display-inventory.component';
import {AdminGuardService} from "./security/admin-guard.service";
import {UserGuardService} from "./security/user-guard.service";
import {MatTableModule} from "@angular/material/table";
import {MatPaginatorModule} from "@angular/material/paginator";
import {MatSortModule} from "@angular/material/sort";
import { CategorySelectComponent } from './category-select/category-select.component';
import {MatButtonToggleModule} from "@angular/material/button-toggle";
import { InventoryComponent } from './inventory/inventory.component';
import { DisplayArticleComponent } from './display-article/display-article.component';
import {MatCardModule} from "@angular/material/card";
import { EditArticleComponent } from './edit-article/edit-article.component';
import {MatSnackBarModule} from "@angular/material/snack-bar";
import { SearchFormComponent } from './search-form/search-form.component';
import {HttpBasicAuthInterceptorService} from "./http-basic-auth-interceptor.service";
import { ToolbarComponent } from './toolbar/toolbar.component';
import { RegisterComponent } from './register/register.component';
import { AddArticleComponent } from './add-article/add-article.component';
import { AddUserSignupComponent } from './add-user-signup/add-user-signup.component';
import { CartComponent } from './cart/cart.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    DisplayInventoryComponent,
    CategorySelectComponent,
    InventoryComponent,
    DisplayArticleComponent,
    EditArticleComponent,
    SearchFormComponent,
    AddArticleComponent,
    AddUserSignupComponent,
    ToolbarComponent,
    ToolbarComponent,
    RegisterComponent,
    CartComponent,
  ],
    imports: [
        BrowserModule,
        HttpClientModule,
        AppRoutingModule,
        BrowserAnimationsModule,
        MatButtonModule,
        MatInputModule,
        MatSelectModule,
        MatFormFieldModule,
        FormsModule,
        ReactiveFormsModule,
        MatTableModule,
        MatSortModule,
        MatPaginatorModule,
        MatButtonToggleModule,
        MatCardModule,
      MatSnackBarModule
    ],
  providers: [
    AdminGuardService,
    UserGuardService,
    {provide: HTTP_INTERCEPTORS,
      useClass: HttpBasicAuthInterceptorService,
      multi: true}
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
