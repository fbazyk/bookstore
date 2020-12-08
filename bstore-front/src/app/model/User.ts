import {Article} from "./Articles";

export class User {
  id?: number;
  username: string;
  password: string;
  enabled?: boolean;
  firstName?: string;
  lastName?: string;
  role?: UserRole;
  favoriteBooks?: Article[]
  favoriteGames?: Article[]
  favoriteLps?: Article[]
}

export enum UserRole {
  ADMIN='ADMIN',
  USER='USER'
}
