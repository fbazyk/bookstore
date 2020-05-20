export class User {
  id: number;
  firstName: string;
  lastName: string;
  role: UserRole;
}

export enum UserRole {
  ADMIN='ADMIN',
  USER='USER'
}
