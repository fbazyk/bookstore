import {User} from "./User";

export interface Review {
  id?: number;
  articleType?: string;
  articleId?: number;
  articleTitle?: string;
  rating?: number;
  description?: string;
  edit?: boolean;
  userId?: number;
  userName?: string;
}
