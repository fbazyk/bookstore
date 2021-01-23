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
  address?: UserAddress;
}

export interface UserAddress {
  street?: string;
  number?: string;
  city?: string;
  postcode?: string
  country?: string;
}

export enum UserRole {
  ADMIN='ADMIN',
  USER='USER'
}
