export class User {
  id?: number;
  username: string;
  password: string;
  enabled?: boolean;
  firstName?: string;
  lastName?: string;
  role?: UserRole;
  favoriteBooks?: number[]
  favoriteGames?: number[]
  favoriteLps?: number[]
}

export enum UserRole {
  ADMIN='ADMIN',
  USER='USER'
}
