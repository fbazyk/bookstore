import {User} from "./User";

export interface Review {
  id?: number;
  articleType?: string;
  articleId?: number;
  articleTitle?: string;
  rating?: number;
  description?: string;
  userId?: number;
  userName?: string;
}
