class User < ApplicationRecord
  has_one :basket, class_name: :Basket, foreign_key: :user_id
  has_many :cart_items, through: :basket

  has_many :orders
  has_many :order_items, through: :orders
  
  after_create :create_cart

  def create_cart
    return if cart_exists?
    create_basket
  end

  def cart_exists?
    basket.present?
  end

  def create_order!
    cart_items = self.cart_items.includes(:product)
    order = self.orders.new
    
    if cart_items.blank?
      order.errors.add(:cart, 'should have some items')
      return order
    end
    
    order.save
    
    cart_items.each do |cart_item|
      order.order_items.create(
        product_id: cart_item.product.id,
        quantity: cart_item.quantity,
        product_name: cart_item.product.name,
        product_price: cart_item.product.price
      )

      cart_item.destroy
    end

    order
  end
end