class ShoppingCart

  # def initialize(token:)
  #   @token = token
  # end

  # def order
  #   @order ||=Order.find_or_create_by(token: @token) do |order|
  #     order.sub_total=0
  #   end
  # end

  # def add_item(product_id:,quantity: 1)
  #   product = Product.find(product_id)
    
  #   cart_item = CartItem.find_or_create_by(
  #     product_id: product_id
  #   )
  #   cart_item.quantity=quantity
  # end


end