export class User {
  id?: number;
  username: string;
  password: string;
  enabled?: boolean;
  firstName?: string;
  lastName?: string;
  role?: UserRole;
}

export enum UserRole {
  ADMIN='ADMIN',
  USER='USER'
}
