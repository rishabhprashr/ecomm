class Basket < ApplicationRecord
    self.table_name = 'carts'
    has_many :cart_items, foreign_key: :cart_id
    belongs_to :user
end
