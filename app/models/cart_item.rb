class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :product

    # def add_item(product_id:,quantity: 1)
    #     product = Product.find(product_id)
        
    #     cart_item = CartItem.find_or_create_by(
    #     product_id: product_id
    #     )
    #     cart_item.quantity=quantity
    # end
end
