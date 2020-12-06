import {User} from "./User";

export interface Review {
  id?: number;
  articleType?: string;
  articleId?: number;
  rating?: number;
  description?: string;
  userId?: number;
  userName?: string;
}
