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
import {HttpClientModule} from "@angular/common/http";
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

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    DisplayInventoryComponent,
    CategorySelectComponent,
    InventoryComponent,
    DisplayArticleComponent,
    EditArticleComponent,
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
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
