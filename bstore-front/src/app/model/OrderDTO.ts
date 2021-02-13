import {Article} from "./Articles";

export interface OrderDTO{
  cartDate: string
  orderDate: string
  id: number
  orderItems: OrderItemDTO[]
  orderTotal: number
}

export interface OrderItemDTO{
  articleId?: number
  articleType?: string
  title?: string
  id?: number
  price?: number
  quantity?: number
  article?: Article
  editQuantity?: boolean
}

export class OrdersDTO{
  orderList: OrderDTO[]
}

