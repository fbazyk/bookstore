import {GameGenre, LpGenre} from "./Genres";

export interface Article{
  type: string;
  id: number;
  title: string;
  price: number;
  supplierId: string;
}


export class Book implements Article {
  type:string = 'book';
  id: number;
  title: string;
  price: number;
  supplierId: string;
  author: string;
  isbn: string;
  pages: number;


  constructor(type: string, id: number, title: string, price: number, supplierId: string, author: string, isbn: string, pages: number) {
    this.type = type;
    this.id = id;
    this.title = title;
    this.price = price;
    this.supplierId = supplierId;
    this.author = author;
    this.isbn = isbn;
    this.pages = pages;
  }
}


export class Game implements Article {
  constructor(article: Article) {

  }

  type:string = 'game';
  id: number;
  title: string;
  price: number;
  supplierId: string;
  publisher: string;
  min_age: number;
  genre: GameGenre
}

export class Lp implements Article {
  type:string = 'game';
  id: number;
  title: string;
  price: number;
  supplierId: string;
  artist: string;
  genre: LpGenre
}

export const typeMapping:any = {
  'book' : Book,
  'game' : Game,
  'lp': Lp
};
