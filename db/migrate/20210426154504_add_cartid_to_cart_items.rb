class AddCartidToCartItems < ActiveRecord::Migration[6.1]
  def change
    change_table :cart_items do |t|
      t.references :cart
      t.references :product
    end
  end
end
