class Product < ApplicationRecord
    belongs_to :category
    has_many :order_items
    has_many :cart_items

    def format
        {
            

        }
    end

end
