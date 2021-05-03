class CartItem < ApplicationRecord
  MIN_QUANTITY = 1
  belongs_to :basket, class_name: :Basket, foreign_key: :cart_id
  belongs_to :product

  validate :validate_quantity

  
  def validate_quantity
    if self.quantity < MIN_QUANTITY
      self.errors.add(:quantity, "should be more than ZERO")
    end
  end

  def format
    {
      id: id,
      created_at: created_at,
      quantity: quantity,
      # price: product.price * quantity,
      product: {
        id: product.id,
        name: product.name,
        price: product.price
      }
    }
  end

  
end
