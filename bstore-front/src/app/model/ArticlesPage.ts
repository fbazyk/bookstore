import {Article} from "./Articles";

export interface ArticlesPage{

  articles: Article[];
  totalArticles?: number;
  currentPage?: number;
  totalPages?: number;

}

export interface PageRequest{
  pageIndex: number;
  pageSize: number;
}
