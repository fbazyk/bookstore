import {GameGenre, LpGenre} from "./Genres";

export type Item = |Book|Game|Lp;

export interface Article{
  type: string;
  id: number;
  title: string;
  price?: number;
  supplierId?: string
  author?: string;
  isbn?: string;
  pages?: number;
  publisher?: string;
  min_age?: number;
  artist?: string;
  genre?: GameGenre|LpGenre;
}

export enum articleType{
  book='book',
  game ='game',
  lp ='lp',
}

export const articleTypes: Array<String> = ['all', 'book', 'game', 'lp'];

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
  type:string = 'lp';
  id: number;
  title: string;
  price: number;
  supplierId: string;
  artist: string;
  genre: LpGenre
}

export const articleTypeMapping:any = {
  'book' : Book,
  'game' : Game,
  'lp': Lp
};
