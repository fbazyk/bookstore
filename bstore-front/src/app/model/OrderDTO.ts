export interface OrderDTO{
  cartDate: string
  orderDate: string
  orderId: number
  orderItems: OrderItem[]
  orderTotal: number
}

export interface OrderItem{
  articleId: number
  articleType: string
  id: number
  price: number
  quantity: number
  editQuantity?: boolean
}
