import { Component, OnInit } from '@angular/core';
import {UserService} from "../user.service";

@Component({
  selector: 'app-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.css']
})
export class ToolbarComponent implements OnInit {

  constructor(private userService:UserService) { }

  ngOnInit(): void {
    console.log("toolbar initialized")
  }

  logout() {
    this.userService.logout();
  }
}
