class User < ApplicationRecord
  InvalidToken = Class.new(StandardError)
  ExpiredToken = Class.new(StandardError)
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  #, :registerable, :recoverable, :rememberable, :validatable
  has_one :basket, class_name: :Basket, foreign_key: :user_id
  has_many :cart_items, through: :basket

  has_many :orders
  has_many :order_items, through: :orders
  
  after_create :create_cart

  validate :validate_credentials

  def validate_credentials
    x = User.where(email: self.email).first
    unless x.nil?
      self.errors.add(:email,"User already exists")
    end
    if self.name.nil? || self.name.empty? || self.name.blank?
      self.errors.add(:name, "Name Cant be blank")
    end
    if self.email.nil? || self.email.empty? || self.email.blank?
      self.errors.add(:email, "Email is required.")
    end
    if self.password.nil? || self.password.empty? || self.password.blank?
      self.errors.add(:password, "Password is required.")
    end
  end

  def create_cart
    return if cart_exists?
    create_basket
  end
  
  def generate_token!
    return token if token.present?
    token = SecureRandom.urlsafe_base64(100)
    self.update_attributes(token: token, token_created_at: Time.now)
    token
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

  class << self
    def validate_token!(token)
      raise InvalidToken if token.blank?

      user = self.where(token: token).first

      raise InvalidToken if user.blank?

      if (Time.now - user.token_created_at) > 2.days
        raise ExpiredToken
      end

      user
    end
  end
end