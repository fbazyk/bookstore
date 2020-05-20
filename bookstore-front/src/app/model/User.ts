export class User {
  id: number;
  firstName: string;
  lastName: string;
  role: UserRole;
}

enum UserRole {
  ADMIN,
  USER
}
